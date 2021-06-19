import cmdline

type
  MemoryId* {.size: sizeof(int32).} = enum
    miCore
    miGraphics
    miAudio
    miVFS
    miGame

  CommandLineArgKind* {.size: sizeof(int32).} = enum
    clakNone
    clakRequired
    clakOptional
    
  RegisterCommandLineArgCallback* = proc(name: cstring; shortName: char; kind: CommandLineArgKind; desc: cstring; valueDesc: cstring) {.cdecl.}
  ModuleConfigCallback* = proc(conf: ptr Config; registerCommandLineArg: RegisterCommandLineArgCallback) {.cdecl.}

  Config* = object
    appName*: cstring
    appTitle*: cstring
    pluginPath*: cstring