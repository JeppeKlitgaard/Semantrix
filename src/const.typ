// Note: No bold since this is only upright/italics difference
#let MATH_STYLES = (
  "italic": math.italic,
  "upright": math.upright,
)

#let MATH_FAMILIES = (
  "serif": math.serif,
  "sans": math.sans,
  "frak": math.frak,
  "mono": math.mono,
  "bb": math.bb,
  "cal": math.cal,
  "scr": math.scr,
)

#let ABOVE_MATH_ACCENTS = (
  // Built-in
  "grave": sym.grave,
  "acute": sym.acute,
  "hat": sym.hat,
  "tilde": sym.tilde,
  "macron": sym.macron,
  "dash": symbol("\u{203E}"), // sym.dash is different
  "breve": sym.breve,
  "dot": sym.dot,
  "dot.double": sym.dot.double,
  "diaer": sym.diaer,
  "dot.triple": sym.dot.triple,
  "dot.quad": sym.dot.quad,
  "circle": sym.circle,
  "acute.double": sym.acute.double,
  "caron": sym.caron,
  "arrow": sym.arrow,
  "arrow.l": sym.arrow.l,
  "->": sym.arrow,
  "<-": sym.arrow.l,
  "arrow.l.r": sym.arrow.l.r,
  "harpoon": sym.harpoon,
  "harpoon.lt": sym.harpoon.lt,
  // Additional
  // See: https://www.compart.com/en/unicode/block/U+0300
  "line": symbol("\u{0305}"),
  "line.double": symbol("\u{033F}"),
  "line.triple": (symbol("\u{0305}"), symbol("\u{0305}"), symbol("\u{0305}"),),
  "line.quadruple": (symbol("\u{0305}"), symbol("\u{0305}"), symbol("\u{0305}"), symbol("\u{0305}"),),
  "line.vert": symbol("\u{030D}"),
  "line.vert.double": symbol("\u{030E}"),
  "grave.double": symbol("\u{030F}"),
  "candrabindu": symbol("\u{0310}"),
  "breve.inv": symbol("\u{0311}"),
  "comma.turn": symbol("\u{0312}"),
  "comma": symbol("\u{0313}"),
  "comma.rev": symbol("\u{0314}"),
  "comma.right": symbol("\u{0315}"),
  "angle.left": symbol("\u{031A}"),
  "horn": symbol("\u{031B}"),
  "cross": symbol("\u{033D}"),
  "times": symbol("\u{033D}"),
  "x": symbol("\u{033D}"),
  "tilde.vert": symbol("\u{033E}"),
  "grave.tone": symbol("\u{0340}"),
  "acute.tone": symbol("\u{0341}"),
  /// Skip a few weird greek ones
  "bridge": symbol("\u{0346}"),
  "tilde.not": symbol("\u{034A}"),
  "homothetic": symbol("\u{034B}"),
  "approx": symbol("\u{034C}"),
  "≈": symbol("\u{034C}"),
  "arrow.head.r": symbol("\u{0350}"),
  "ring.half.l": symbol("\u{0351}"),
  "fermata": symbol("\u{0352}"),
  "ring.half.r": symbol("\u{0357}"),
  "dot.r": symbol("\u{0358}"),
  "zigzag": symbol("\u{035B}"),
  "breve.double": symbol("\u{035D}"),
  "macron.double": symbol("\u{035E}"),
  "tilde.double": symbol("\u{0360}"),
  "breve.inv.double": symbol("\u{0361}"),
  // Skipping the selection of latin letters
  // See: https://www.compart.com/en/unicode/block/U+20D0
  "arrow.ccw": symbol("\u{20D4}"),
  "arrow.cw": symbol("\u{20D5}"),
  "asterisk": symbol("\u{20F0}"),
  "*": symbol("\u{20F0}"),
)

#let BELOW_MATH_ACCENTS = (
  // These are all additional accents since built-in ones only support above
  "grave": symbol("\u{0316}"),
  "acute": symbol("\u{0317}"),
  "tack.l": symbol("\u{0318}"),
  "tack.r": symbol("\u{0319}"),
  "ring.half.l": symbol("\u{031C}"),
  "tack": symbol("\u{031D}"),
  "tack.u": symbol("\u{031D}"),
  "tack.inv": symbol("\u{031E}"),
  "tack.d": symbol("\u{031E}"),
  "plus": symbol("\u{031F}"),
  "+": symbol("\u{031F}"),
  "minus": symbol("\u{0320}"),
  "-": symbol("\u{0320}"),
  // Skip weird hooks
  "dot": symbol("\u{0323}"),
  "dot.double": symbol("\u{0324}"), // No double dot below, so just use the same one
  "diaer": symbol("\u{0324}"),
  "ring": symbol("\u{0325}"),
  "comma": symbol("\u{0326}"),
  "cedilla": symbol("\u{0327}"),
  "ogonek": symbol("\u{0328}"),
  "line.vert": symbol("\u{0329}"),
  "bridge": symbol("\u{032A}"),
  "arch.double": symbol("\u{032B}"),
  "caron": symbol("\u{032C}"),
  "hat.inv": symbol("\u{032C}"),
  "hat": symbol("\u{032D}"),
  "breve": symbol("\u{032E}"),
  "breve.inv": symbol("\u{032F}"),
  "tilde": symbol("\u{0330}"),
  "macron": symbol("\u{0331}"),
  "line": symbol("\u{0332}"),
  "dash": symbol("\u{0332}"),
  "line.double": symbol("\u{0333}"),
  "ring.half.r": symbol("\u{0339}"),
  "bridge.inv": symbol("\u{033A}"),
  "square": symbol("\u{033B}"),
  "seagull": symbol("\u{033C}"),
  "equals": symbol("\u{0347}"),
  "=": symbol("\u{0347}"),
  "line.vert.double": symbol("\u{0348}"),
  "angle.left": symbol("\u{0349}"),
  "arrow.l.r": symbol("\u{034D}"),
  "arrow.u": symbol("\u{034E}"),
  "x": symbol("\u{0353}"),
  "cross": symbol("\u{0353}"),
  "arrow.head.l": symbol("\u{0354}"),
  "arrow.head.r": symbol("\u{0355}"),
  "arrow.head.r.u": symbol("\u{0356}"),
  "asterisk": symbol("\u{0359}"),
  "*": symbol("\u{0359}"),
  "ring.double": symbol("\u{035A}"),
  "breve.double": symbol("\u{035C}"),
  "macron.double": symbol("\u{035F}"),
  "arrow.r.double": symbol("\u{0362}"),
  // See: https://www.compart.com/en/unicode/block/U+20D0
  "dot.triple": symbol("\u{20E8}"),
  // And additional ones as arrays
  "line.triple": (symbol("\u{0331}"), symbol("\u{0331}"), symbol("\u{0331}"),),
  "line.quadruple": (symbol("\u{0331}"), symbol("\u{0331}"), symbol("\u{0331}"), symbol("\u{0331}"),),
)

// I wish these were exposed in Typst directly
#let MATCHED_DELIMITERS = (
  "(": ")",   // Parentheses
  "[": "]",   // Square brackets
  "{": "}",   // Curly braces
  "<": ">",   // Less-than / Greater-than (often parsed as angle brackets)
  "⌈": "⌉",   // Ceiling
  "⌊": "⌋",   // Floor
  "⌜": "⌝",   // Quine corners (Upper)
  "⌞": "⌟",   // Quine corners (Lower)
  "❲": "❳",   // Light tortoise shell
  "⟦": "⟧",   // Iverson brackets / Jump brackets
  "⟨": "⟩",   // Mathematical angle brackets (Inner products, Bra-ket)
  "⟪": "⟫",   // Double angle brackets
  "⟬": "⟭",   // White tortoise shell
  "⟮": "⟯",   // Flattened parentheses
  "⦃": "⦄",   // Multisets
  "⦅": "⦆",   // White parentheses
  "⦇": "⦈",   // Z notation image brackets
  "⦉": "⦊",   // Z notation binding brackets
  "⦋": "⦌",   // Square brackets with underbar
  "⦍": "⦎",   // Square brackets with top tick
  "⦏": "⦐",   // Square brackets with bottom tick
  "⦑": "⦒",   // Angle brackets with dot
  "⦓": "⦔",   // Arc less-than / greater-than
  "⦕": "⦖",   // Double arc less-than / greater-than
  "⦗": "⦘",   // Black tortoise shell
  "⧘": "⧙",   // Wiggly fence
  "⧚": "⧛",   // Double wiggly fence
  "⧼": "⧽",   // Curved angle brackets
)

#let FENCES = (
  "|",  // U+007C Vertical line (absolute value, determinant, evaluation)
  "‖",  // U+2016 Double vertical line
  "∥",  // U+2225 Parallel to (often used interchangeably with U+2016 for norms)
  "⦀",  // U+2980 Triple vertical bar (operator norms in Banach spaces)
  "¦",  // U+00A6 Broken bar
  "∣",  // U+2223 Divides (standard relation, but occasionally parsed as a fence)
)
