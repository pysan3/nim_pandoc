## https://hackage.haskell.org/package/pandoc-types-1.23/docs/Text-Pandoc-Definition.html#t*:Inline
## data Inline
##
## > Inline elements

import std/json
import std/jsonutils

type
  PDInline* = ref object of RootObj
    t*: string
  PDInlineBase0* = ref object of PDInline
  PDInlineBase*[T] = ref object of PDInline
    c*: T
