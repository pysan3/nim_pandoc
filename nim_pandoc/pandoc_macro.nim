import std/macros
import std/strutils
import std/sequtils
import std/strformat

macro refObjectJsonHook*(baseType: untyped, conds: untyped): untyped =
  var body = newSeq[string](0)
  body.add("type")
  for rcond in conds:
    for t in rcond[0]:
      var typename = repr(t)[1 ..< ^1]
      body.add(&"  {repr(baseType)}{typename}* = {repr(rcond[1]).strip}")
  body.add("")
  body.add(&"proc toJsonHook*(self: {repr(baseType)}): JsonNode =")
  body.add("  case self.t:")
  for rcond in conds:
    body.add("    of " & rcond[0].mapIt(repr(it)).join(", ") & ":")
    body.add(&"      result = toJson(cast[{repr(rcond[1]).strip}](self))")
  body.add("    else: discard\n")
  body.add(&"proc fromJsonHook*(self: var {repr(baseType)}, o: JsonNode, opt = Joptions()) =")
  body.add("""  case o{"t"}.getStr():""")
  for rcond in conds:
    body.add("    of " & rcond[0].mapIt(repr(it)).join(", ") & ":")
    body.add(&"      self = jsonTo(o, {repr(rcond[1]).strip})")
  body.add("    else: discard\n")
  body.add(&"proc `$`*(self: {repr(baseType)}): string =")
  body.add("  case self.t:")
  for rcond in conds:
    body.add("    of " & rcond[0].mapIt(repr(it)).join(", ") & ":")
    body.add(&"      result = $(toJson(cast[{repr(rcond[1]).strip}](self)))")
  body.add("    else: discard\n")
  result = parseStmt(body.join("\n"))
