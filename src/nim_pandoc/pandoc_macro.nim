import macros
import std/strutils
import std/sequtils
import strformat

macro refObjectJsonHook*(baseType: untyped, conds: untyped): untyped =
  var body = newSeq[string](0)
  body.add(&"proc toJsonHook*(self: {repr(baseType)}): JsonNode =")
  body.add("""  echo self.t""")
  body.add("  case self.t:")
  for rcond in conds:
    body.add("    of " & rcond[0].mapIt(repr(it)).join(", ") & ":")
    body.add(&"      result = toJson(cast[{repr(rcond[1]).strip}](self))")
  body.add("    else: discard\n")
  body.add(&"proc fromJsonHook*(self: var {repr(baseType)}, o: JsonNode, opt = Joptions()) =")
  body.add("""  echo o{"t"}.getStr()""")
  body.add("""  case o{"t"}.getStr():""")
  for rcond in conds:
    body.add("    of " & rcond[0].mapIt(repr(it)).join(", ") & ":")
    body.add(&"      self = jsonTo(o, {repr(rcond[1]).strip})")
  body.add("    else: discard\n")
  result = parseStmt(body.join("\n"))
