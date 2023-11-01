import std/options

import pd_inline_h
import pd_block_h

type
  PDShortCaption* = seq[PDInline]
  PDCaption* = (Option[PDShortCaption], seq[PDBlock])
