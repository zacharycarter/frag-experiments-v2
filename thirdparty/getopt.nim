when defined(vcc):
  {.passC: "/Zi".}
  {.passC: "/I H:\\Projects\\frag\\thirdparty\\getopt\\include".}
  {.compile: "H:\\Projects\\frag\\thirdparty\\getopt\\src\\getopt.c".}

type
  getopt_option_type_t* {.size: sizeof(int32).} = enum
    GETOPT_OPTION_TYPE_NO_ARG, GETOPT_OPTION_TYPE_REQUIRED,
    GETOPT_OPTION_TYPE_OPTIONAL, GETOPT_OPTION_TYPE_FLAG_SET,
    GETOPT_OPTION_TYPE_FLAG_AND, GETOPT_OPTION_TYPE_FLAG_OR


type
  getopt_option_t* = object
    name*: cstring
    name_short*: cint
    `type`*: getopt_option_type_t
    flag*: ptr cint
    value*: cint
    desc*: cstring
    value_desc*: cstring

  getopt_context_t* = object
    argc*: cint
    argv*: cstringArray
    opts*: ptr getopt_option_t
    num_opts*: cint
    current_index*: cint
    current_opt_arg*: cstring


proc getopt_create_context*(ctx: ptr getopt_context_t; argc: cint; argv: cstringArray;
                           opts: ptr getopt_option_t): cint {.importc.}
proc getopt_next*(ctx: ptr getopt_context_t): cint {.importc.}
proc getopt_create_help_string*(ctx: ptr getopt_context_t; buffer: cstring;
                               buffer_size: csize_t): cstring {.importc.}