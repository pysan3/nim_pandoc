type
  PDInline* = ref object of RootObj
    t*: string
  PDInlineBase0* = ref object of PDInline
  PDInlineBase*[T] = ref object of PDInline
    c*: T
