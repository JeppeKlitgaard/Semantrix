
/// Attaches scripts and accents to a math base while forcing limits-style placement.
/// -> content
#let ez-attach(
  /// Base expression to decorate with attachments.
  /// -> content
  x,
  /// Positional attachment arguments forwarded to @@math.attach.
  ..attach-args
) = {
  math.scripts(math.attach(math.limits(x), ..attach-args))
}

/// Applies @n underlines to @x
/// -> content
#let underlines(
  /// The content to underline
  /// -> content
  x,
  /// Number of underlines to apply
  /// -> integer
  n,
) = {
  let undermacron(base, size: 100%) = math.accent(base, "\u{0331}", size: size)
  let ul(base, size: 100%) = math.accent(base, "\u{0332}", size: size)
  let ull(base, size: 100%) = math.accent(base, "\u{0333}", size: size)
  let underliner = x => ez-attach(x, b: box(line(length: 0.5em, stroke: 0.5pt), height: -0.2em))
  for _ in range(n) {
    // x = math.underline(x)
    // x = underliner(x)
    x = undermacron(x)
  }
  x
}

#let _adjuster(body, factor, dy) = move(scale(body, factor, reflow: true), dy: dy)

/// Accents supported by the @below option
/// These need to be manually adjusted, so we only include relevant ones for now
#let BELOW_ACCENT_CONTENTS = (
  "tilde": _adjuster(sym.tilde, 80%, -0.45em),
  "arrow": _adjuster("←", 60%, -0.45em),
)
