import std/options
import std/jsonutils
import std/json

import pd_block_h
import pd_caption_h

func fromJsonHook*(self: var PDCaption, o: JsonNode, opt = Joptions()) =
  self.t = o["t"].getStr()
  var elems = o{"c"}.getElems()
  if elems[0].kind == JNull:
    self.c = (none(PDShortCaption), jsonTo(elems[1], seq[PDBlock]))
  else:
    self.c = (some(jsonTo(elems[0], PDShortCaption)), jsonTo(elems[1], seq[PDBlock]))
