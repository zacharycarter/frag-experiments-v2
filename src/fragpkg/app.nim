import os, strutils,
       allocator, cmdline, string_helpers

when defined(windows):
  import winim/lean

  proc messageBox(msg: cstring) =
    MessageBoxA(HWND(0), msg, "frag", MB_OK or MB_ICONERROR)
  
  proc messageBox(msg: var openArray[char]) =
    MessageBoxA(HWND(0), cast[cstring](addr msg[0]), "frag", MB_OK or MB_ICONERROR)

type
  App = object
    alloc: ptr Allocator

var gApp: App

proc entry*(): int =
  gApp.alloc = allocMalloc()

  var
    profileGPU = 0'i32
    dumpUnusedAssets = 0'i32
    crashDump = 0'i32
  
  var 
    commandLineOpts = [
      CommandLineOpt(name: "run", nameShort: int32('r'), opType: clotRequired, flag: nil, value: int32('r'), desc: "Module to run with frag", valueDesc: "filepath"),
      optEnd()
    ]
    args = @[getAppFilename()]
  add(args, commandLineParams())

  let
    argv = allocCStringArray(args) 
    cmdlineCtx = createCommandLineContext(gApp.alloc, int32(paramCount() + 1), argv, commandLineOpts)

  var
    opt: int32
    arg: cstring
    errorMsg: array[512, char]
    moduleFilepath: cstring = nil
    cwd: cstring = nil
    firstMip = 0'i32

  opt = next(cmdlineCtx, nil, addr(arg))
  while opt != -1:
    case char(opt)
    of '+':
      discard snprintf(errorMsg, sizeof(errorMsg), "Got argument without flag: %s", arg)
      messageBox(errorMsg)
    of '!':
      discard snprintf(errorMsg, sizeof(errorMsg), "Invalid use of argument: %s", arg)
      messageBox(errorMsg)
      quit(QuitFailure)
    of 'r':
      moduleFilepath = arg
    of 'c':
      cwd = arg
    of 'M':
      firstMip = toInt(arg)
    else:
      discard
    opt = next(cmdlineCtx, nil, addr(arg))

  echo moduleFilepath

  deallocCStringArray(argv)

  result = QuitSuccess