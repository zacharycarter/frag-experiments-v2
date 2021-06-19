import api, allocator

type
  Core = object
    heapAlloc: ptr Allocator

var gCore: Core

proc init*(conf: ptr Config): bool =
  gCore.heapAlloc = allocMalloc()