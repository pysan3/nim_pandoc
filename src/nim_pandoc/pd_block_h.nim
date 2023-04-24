## https://hackage.haskell.org/package/pandoc-types-1.23/docs/Text-Pandoc-Definition.html#t*:Block
## data Block
##
## > Block elements

type
  PDBlock* = ref object of RootObj
    t*: string
  PDBlockBase0* = ref object of PDBlock
  PDBlockBase*[T] = ref object of PDBlock
    c*: T
