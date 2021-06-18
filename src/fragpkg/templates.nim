template alignMask*(value, mask: untyped): untyped =
  (((value.uint) + (mask.uint)) and ((not 0'u) and (not(mask.uint))))

proc `-`*[T](a, b: ptr T): int =
  return (cast[ByteAddress](a) - cast[ByteAddress](b)) div sizeof(T)