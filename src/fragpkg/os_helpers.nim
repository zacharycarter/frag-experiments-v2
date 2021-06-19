when defined(posix):
  import posix

proc dlError*(): cstring =
  when defined(windows):
    result = ""
  else:
    result = dlerror()