import strformat

type
  PDAttrPair* = (string, string)
  PDAttr* = (string, seq[string], seq[PDAttrPair])

func key*(self: PDAttrPair): string = self[0]
func value*(self: PDAttrPair): string = self[1]

func identifier*(self: PDAttr): string = self[0]
func classes*(self: PDAttr): seq[string] = self[1]
func pairs*(self: PDAttr): seq[PDAttrPair] = self[2]

func `$`*(self: PDAttr): string =
  &"( '{self.identifier}', {self.classes}, {self.pairs} )"
