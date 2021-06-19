import api, allocator, string_helpers

type
  Core = object
    heapAlloc: ptr Allocator
    heapProxyAlloc: Allocator

    appName: array[32, char]

var gCore: Core

proc alloc(memId: MemoryId): ptr Allocator =
  result = addr(gCore.heapProxyAlloc)

proc init*(conf: ptr Config): bool =
  gCore.heapAlloc = allocMalloc()

  gCore.heapProxyAlloc = gCore.heapAlloc[]

  let alloc = alloc(miCore)
  gCore.appName = toCharArray[len(gCore.appName)](conf.appName)

  result = true