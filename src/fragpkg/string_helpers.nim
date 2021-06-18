

import ../../thirdparty/stb_sprintf

proc atoi(str: cstring): int32 {.importc, cdecl, header: "stdlib.h".}

proc toInt*(str: cstring): int32 =
  result = atoi(str)

proc vsnprintf(str: var openArray[char]; size: int; fmt: cstring; args: va_list): int32 =
  result = stbsp_vsnprintf(cast[cstring](addr(str[0])), int32(size), fmt, args)

proc snprintf*(str: var openArray[char]; size: int; fmt: cstring): int32 {.varargs, cdecl.} =
  var args: va_list
  va_start(args, fmt)
  result = vsnprintf(str, size, fmt, args)
  va_end(args)

