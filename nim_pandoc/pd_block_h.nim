type
  PDBlock* = ref object of RootObj
    t*: string
  PDBlockBase0* = ref object of PDBlock
  PDBlockBase*[T] = ref object of PDBlock
    c*: T
