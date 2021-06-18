import ptr_math,
       config, reflection, templates

type
  MemoryFailureCallback = proc(sourceFile: cstring; line: uint32) {.cdecl.}

  Allocator* = object
    allocCb*: proc(p: pointer; size: uint; align: uint32; file, funcName: cstring; line: uint32; userData: pointer): pointer
    userData*: pointer

var 
  gAllocMalloc: Allocator
  gAllocFailedCb: MemoryFailureCallback

proc setMemFailureCallback*(memFailCb: MemoryFailureCallback) =
  gAllocFailedCb = memFailCb

proc runMemFailureCallback(sourceFile: cstring; line: uint32) =
  if gAllocFailedCb != nil:
    gAllocFailedCb(sourceFile, line)

template memoryFailure() =
  let iinfo = instantiationInfo()
  runMemFailureCallback(iinfo.filename, uint32(iinfo.line))
  doAssert(false, "Out of memory")

template outOfMemory*() =
  memoryFailure()

template free(p: pointer) =
  when compileOption("threads"):
    deallocShared(p)
  else:
    dealloc(p)

template malloc(size: uint): untyped =
  when compileOption("threads"):
    allocShared(size)
  else:
    alloc(size)

template realloc(p: pointer; size: uint): pointer =
  when compileOption("threads"):
    reallocShared(p, size)
  else:
    realloc(p, size)

when defined(vcc):
  proc alignedFree(p: pointer) {.sideeffect, importc:"_aligned_free", header:"<malloc.h>".}
else:
  # TODO: Implement
  discard

when defined(vcc):
  proc alignedMalloc(size, alignment: csize_t): pointer {.sideeffect,importc:"_aligned_malloc", header:"<malloc.h>".}
else:
  # TODO: Implement
  discard

when defined(vcc):
  proc alignedRealloc(p: pointer; size, alignment: csize_t): pointer {.sideeffect,importc:"_aligned_realloc", header:"<malloc.h>".}
else:
  # TODO: Implement
  discard

proc allocMalloc*(): ptr Allocator =
  result = addr(gAllocMalloc)
  
proc isAligned*(p: pointer; align: uint32): bool =
  type
    PtrAddr {.union.} = object
      p: pointer
      address: uint
  
  let un = PtrAddr(p: p)
  result = 0 == (un.address and (align - 1))

proc alignPtr*(p: pointer; extra: uint; align: uint32): pointer = 
  type
    PtrAddr {.union.} = object
      p: pointer
      address: uint
  
  var un = PtrAddr(p: p)
  let
    unaligned = un.address + extra
    mask = align - 1
    aligned = alignMask(unaligned, mask)
  un.address = aligned
  result = un.p

proc allocCb(p: pointer; size: uint; align: uint32; file, funcName: cstring; line: uint32; userData: pointer): pointer =
  if size == 0:
    if p != nil:
      if align <= NaturalAlignment:
        free(p)
        return nil

      when defined(vcc):
        alignedFree(p)
      else:
        alignedFree(addr(gAllocMalloc), p, file, funcName, line)

    return nil
  
  elif isNil(p):
    if align <= NaturalAlignment:
      return malloc(size)

    when defined(vcc):
      return alignedMalloc(size, align)
    else:
      return alignedMalloc(addr(gAllocMalloc), size, align, file, funcName, line)
  
  else:
    if align <= NaturalAlignment:
      return realloc(p, size)

    when defined(vcc):
      return alignedRealloc(p, size, align)
    else:
      return alignedRealloc(addr(gAllocMalloc), p, size, align, file, funcName, line)
        
gAllocMalloc.allocCb = allocCb

proc malloc(alloc: ptr Allocator; size: uint; align: uint32; file, funcName: cstring; line: uint32): pointer =
  result = alloc.allocCb(nil, size, align, file, funcName, line, alloc.userData)

proc free(alloc: ptr Allocator; p: pointer; align: uint32; file, funcName: cstring; line: uint32) =
  discard alloc.allocCb(p, 0, align, file, funcName, line, alloc.userData)

proc realloc(alloc: ptr Allocator; p: pointer; size: uint; align: uint32; file, funcName: cstring; line: uint32): pointer =
  result = alloc.allocCb(p, size, align, file, funcName, line, alloc.userData)

proc alignedAlloc(alloc: ptr Allocator; size: uint; align: uint32; file, funcName: cstring; line: uint32): pointer =
  let 
    alignment = max(align, NaturalAlignment)
    total = size + alignment + uint(sizeof(uint32))
    p = cast[ptr uint8](malloc(alloc, total, 0, file, funcName, line))
  assert(p != nil)
  result = cast[ptr uint8](alignPtr(p, uint(sizeof(uint32)), alignment))
  var header = cast[ptr uint32](result) - 1
  header[] = uint32(uint(cast[ptr uint8](result) - p))

proc alignedFree(alloc: ptr Allocator; p: var pointer; file, funcName: cstring; line: uint32) =
  let 
    aligned = cast[ptr uint8](p)
    header = cast[ptr uint32](aligned) - 1
  p = aligned - int(header[])
  free(alloc, p, 0, file, funcName, line)

proc alignedRealloc(alloc: ptr Allocator; p: var pointer; size: uint; align: uint32; file, funcName: cstring; line: uint32): pointer =
  if isNil(p):
    return alignedAlloc(alloc, size, align, file, funcName, line)

  var aligned = cast[ptr uint8](p)
  let offset = cast[ptr uint32](aligned - 1)[]
  p = aligned - int(offset)

  let 
    alignment = max(align, NaturalAlignment)
    total = size + alignment + uint(sizeof(uint32))
  p = realloc(alloc, p, total, 0, file, funcName, line)
  assert(p != nil)
  result = cast[ptr uint8](alignPtr(p, uint(sizeof(uint32)), alignment))

  if result == aligned:
    return aligned

  aligned = cast[ptr uint8](p) + int(offset)
  moveMem(result, aligned, size)
  let header = cast[ptr uint32](result) - 1
  header[] = uint32(cast[ptr uint8](result) - cast[ptr uint8](p))
  
proc calloc*(alloc: ptr Allocator; size: uint; align: uint32; file, funcName: cstring; line: uint32): pointer =
  result = alloc.allocCb(nil, size, align, file, funcName, line, alloc.userData)
  if result != nil:
    zeroMem(result, size)

when defined(debugAllocMallocator):
  template malloc*(allocator, size: untyped): untyped =
    let iinfo = instantiationInfo()
    malloc(allocator, uint(size), 0, iinfo.filename, getBackendProcName(), iinfo.line)
  template realloc*(allocator, p, size: untyped): untyped =
    let iinfo = instantiationInfo()
    realloc(allocator, p, uint(size), 0, iinfo.filename, getBackendProcName(), iinfo.line)
  template free*(allocator, p: untyped) =
    let iinfo = instantiationInfo()
    free(allocator, p, 0, iinfo.filename, getBackendProcName(), iinfo.line)
  template alignedMalloc*(allocator, size, align: untyped): untyped =
    let iinfo = instantiationInfo()
    malloc(allocator, uint(size), align, iinfo.filename, getBackendProcName(), iinfo.line)
  template alignedRealloc*(allocator, p, size, align: untyped): untyped =
    let iinfo = instantiationInfo()
    realloc(allocator, p, uint(size), align, iinfo.filename, getBackendProcName(), iinfo.line)
  template alignedFree*(allocator, p, align: untyped) =
    let iinfo = instantiationInfo()
    free(allocator, p, align, iinfo.filename, getBackendProcName(), iinfo.line)
  template calloc*(allocator, size: untyped): untyped =
    let iinfo = instantiationInfo()
    calloc(allocator, uint(size), 0, iinfo.filename, getBackendProcName(), iinfo.line)
  template alignedCalloc*(allocator, size, align: untyped): untyped =
    let iinfo = instantiationInfo()
    calloc(allocator, uint(size), align, iinfo.filename, getBackendProcName(), iinfo.line)
else:
  template malloc*(allocator, size: untyped): untyped =
    malloc(allocator, uint(size), 0, nil, nil, 0)
  template realloc*(allocator, p, size: untyped): untyped =
    realloc(allocator, p, uint(size), 0, nil, nil, 0)
  template free*(allocator, p: untyped) =
    free(allocator, p, 0, nil, nil, 0)
  template alignedMalloc*(allocator, size, align: untyped): untyped =
    malloc(allocator, uint(size), align, nil, nil, 0)
  template alignedRealloc*(allocator, p, size, align: untyped): untyped =
    realloc(allocator, p, uint(size), align, nil, nil, 0)
  template alignedFree*(allocator, p, align: untyped) =
    free(allocator, p, align, nil, nil, 0)
  template calloc*(allocator, size: untyped): untyped =
    calloc(allocator, uint(size), 0, nil, nil, 0)
  template alignedCalloc*(allocator, size, align: untyped): untyped =
    calloc(allocator, uint(size), align, nil, nil, 0)