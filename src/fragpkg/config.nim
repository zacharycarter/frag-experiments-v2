when defined(macosx):
  const NaturalAlignment* = 16
else:
  const NaturalAlignment* = 8

const
  MaxPath* = 256