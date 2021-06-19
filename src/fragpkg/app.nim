import dynlib, os, strformat,
       ../../thirdparty/sokol,
       allocator, api, cmdline, os_helpers, string_helpers

when defined(windows):
  import winim/lean

  proc messageBox(msg: cstring) =
    MessageBoxA(HWND(0), msg, "frag", MB_OK or MB_ICONERROR)
  
  proc messageBox(msg: var openArray[char]) =
    MessageBoxA(HWND(0), cast[cstring](addr msg[0]), "frag", MB_OK or MB_ICONERROR)

type
  ValuePtr {.union.} = object
    value: array[8, char]
    valuePtr: ptr char

  CommandLineItem = object
    name: array[64, char]
    allocatedValue: bool
    valPtr: ValuePtr

  App = object
    conf: Config
    alloc: ptr Allocator
    moduleFilepath: array[MaxPath, char]
    cmdLineArgs: seq[CommandLineOpt]
    cmdLineItems: seq[CommandLineItem]

var 
  gApp: App

  defaultName: array[64, char]
  defaultTitle: array[64, char]

template saveConfigStr(cacheStr, str: untyped) =
  if str != nil:
    copyMem(addr(cacheStr[0]), addr(str[0]), len(str))
    str = addr(cacheStr[0])
  else:
    str = addr(cacheStr[0])

proc commandLineArg(name: cstring; shortName: char; kind: CommandLineArgKind; desc: cstring; valueDesc: cstring) {.cdecl.} =
  block outer:
    for opt in gApp.cmdLineArgs:
      if opt.name == name:
        assert(false, fmt"Command-line argument '{name}' is already registered")
        break outer
    
    let opt = CommandLineOpt(
      name: name,
      shortName: int32(shortName),
      opType: CommandLineOpType(kind),
      value: 1,
      desc: desc,
      valueDesc: valueDesc,
    )

    add(gApp.cmdLineArgs, opt)

proc init() {.cdecl.} =
  var errorMsg: array[512, char]

  if not core.init(addr(gApp.conf)):
    messageBox("failed initializing core subsystem, see log for details")
    quit(QuitFailure)

proc update() {.cdecl.} =
  discard

proc shutdown() {.cdecl.} =
  sapp_quit()


proc entry*(): int =
  gApp.alloc = allocMalloc()

  var
    profileGPU = 0'i32
    dumpUnusedAssets = 0'i32
    crashDump = 0'i32

    commandLineOpts = [
      CommandLineOpt(name: "run", shortName: int32('r'), opType: clotRequired, flag: nil, value: int32('r'), desc: "Module to run with frag", valueDesc: "filepath"),
      optEnd()
    ]
    args = @[getAppFilename()]

  add(args, commandLineParams())

  let
    argv = allocCStringArray(args) 
    cmdlineCtx = createCommandLineContext(gApp.alloc, int32(paramCount() + 1), argv, commandLineOpts)
  
  block outer:
    block inner:
      var
        opt: int32
        arg: cstring
        errorMsg: array[512, char]
        moduleFilepath: string
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
          break inner
        of 'r':
          moduleFilepath = $arg
        of 'c':
          cwd = arg
        of 'M':
          firstMip = toInt(arg)
        else:
          discard
        opt = next(cmdlineCtx, nil, addr(arg))

      when not defined(bundleApp):
        if len(moduleFilepath) == 0:
          messageBox("Provide a module to run (--run)")
          break inner

        if not fileExists(moduleFilepath):
          discard snprintf(errorMsg, sizeof(errorMsg), "Module '%s' does not exist", moduleFilepath)
          messageBox(errorMsg)
          break inner
        
        let moduleDLL = loadLib(moduleFilepath)
        if isNil(moduleDLL):
          discard snprintf(errorMsg, sizeof(errorMsg), "Module '%s' is not a valid shared library: %s", moduleFilepath, dlError())
          messageBox(errorMsg)
          break inner

        let moduleConfigProc = cast[ModuleConfigCallback](symAddr(moduleDLL, "configureFragModule"))
        if isNil(moduleConfigProc):
          discard snprintf(errorMsg, sizeof(errorMsg), "Symbol 'configureFragModule' not found in module: %s", moduleFilepath)
          messageBox(errorMsg)
          break inner
      else:
        #TODO: implement
        discard

      var (_, name, _) = splitFile(moduleFilepath)
      defaultName = toCharArray[len(defaultName)](name)
      defaultTitle = toCharArray[len(defaultTitle)](name)
      
      var conf = Config(
        appName: defaultName,
        appTitle: defaultTitle,
        pluginPath: "",
      )

      moduleConfigProc(addr(conf), commandLineArg)

      echo conf.appTitle
      echo defaultTitle

      saveConfigStr(defaultName, conf.appName)
      saveConfigStr(defaultTitle, conf.appTitle)

      echo conf.appTitle
      echo defaultTitle

      when not defined(bundleApp):
        unloadLib(moduleDLL)
        destroyCommandLineContext(cmdlineCtx, gApp.alloc)
        deallocCStringArray(argv)

      echo conf.appTitle
      echo defaultTitle

      gApp.conf = conf
      gApp.moduleFilepath = toCharArray[len(gApp.moduleFilepath)](moduleFilepath)

      var appDesc = sapp_desc(
        init_cb: init,
        frame_cb: update,
        cleanup_cb: shutdown,
        width: 960,
        height: 540,
        window_title: "foo",
        sample_count: 4,
        swap_interval: 1,
      )

      sapp_run(addr(appDesc))

      result = QuitSuccess
      break outer

    destroyCommandLineContext(cmdlineCtx, gApp.alloc)
    deallocCStringArray(argv)
    result = QuitFailure