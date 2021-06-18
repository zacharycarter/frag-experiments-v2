when defined(vcc):
  {.passC: "/I H:\\Projects\\frag\\thirdparty\\stb".}
  {.compile: "H:\\Projects\\frag\\thirdparty\\stb_sprintf.c".}

type
  va_list* {.importc, header: "<stdarg.h>".} = object

proc va_start*(ap: va_list, paramN: any) {.importc, header: "<stdarg.h>".}
proc va_end*(ap: va_list) {.importc, header: "<stdarg.h>".}

type
  STBSP_SPRINTFCB* = proc (buf: cstring; user: pointer; len: cint): cstring

proc stbsp_vsprintf*(buf: cstring; fmt: cstring; va: va_list): cint {.importc, cdecl.}
proc stbsp_vsnprintf*(buf: cstring; count: cint; fmt: cstring; va: va_list): cint {.importc, cdecl.}
proc stbsp_sprintf*(buf: cstring; fmt: cstring): cint {.varargs, importc, cdecl.}
proc stbsp_snprintf*(buf: cstring; count: cint; fmt: cstring): cint {.varargs, importc, cdecl.}
proc stbsp_vsprintfcb*(callback: ptr STBSP_SPRINTFCB; user: pointer; buf: cstring;
                      fmt: cstring; va: va_list): cint {.importc, cdecl.}
proc stbsp_set_separators*(comma: char; period: char) {.importc, cdecl.}