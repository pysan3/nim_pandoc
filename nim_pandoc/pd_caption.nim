import std/options
import std/jsonutils
import std/json

import pd_block_h
import pd_caption_h
import pd_block

proc fromJsonHook*(self: var PDCaption, o: JsonNode, opt = Joptions()) =
  var elems = o.getElems()
  if elems[0].kind == JNull:
    self = (none(PDShortCaption), jsonTo(elems[1], seq[PDBlock]))
  else:
    self = (some(jsonTo(elems[0], PDShortCaption)), jsonTo(elems[1], seq[PDBlock]))
