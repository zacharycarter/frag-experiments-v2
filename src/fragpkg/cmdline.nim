import ../../thirdparty/getopt,
       allocator

type
  CommandLineOpType* {.size: sizeof(int32).} = enum
    clotNoArg
    clotRequired
    clotOptional
    clotFlagSet
    clotFlagAnd
    clotFlagOr

  CommandLineOpt* {.bycopy.} = object
    name*: cstring
    nameShort*: int32
    opType*: CommandLineOpType
    flag*: ptr int32
    value*: int32
    desc*: cstring
    valueDesc*: cstring

  CommandLineContext* = getopt_context_t

template optEnd*(): untyped =
   CommandLineOpt(name: nil, nameShort: 0, opType: clotNoArg, flag: nil, value: 0'i32, desc: nil, valueDesc: nil)

proc createCommandLineContext*(alloc: ptr Allocator; argc: cint; argv: cstringArray; opts: var openArray[CommandLineOpt]): ptr CommandLineContext =
  result = cast[ptr CommandLineContext](malloc(alloc, sizeof(CommandLineContext)))
  if isNil(result):
    outOfMemory()
  
  let r = getopt_create_context(result, argc, argv, cast[ptr getopt_option_t](addr(opts[0])))

  if r < 0:
    free(alloc, result)
    result = nil

proc next*(ctx: ptr CommandLineContext; index: ptr int32; arg: ptr cstring): int32 =
  result = getopt_next(ctx)
  if result != -1:
    if index != nil:
      index[] = ctx.current_index
    if arg != nil:
      arg[] = ctx.current_opt_arg
  