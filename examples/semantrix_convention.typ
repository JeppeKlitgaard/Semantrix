#import "@preview/semantrix:0.1.0": object, vv, mm, set_

#let ss = object("ss", "scalar")
#let tt = object("tt", "tensor")
#show: set_(vv, mm, tt, ss, preset: "semantrix")

= Semantrix Mathematical Object Convention

This briefly outlines a convention proposed by me, Jeppe, and the reasons why I find it to be superior to other conventions.

== Convention

#figure(table(
  columns: 6,
  table.header([*Object*], [*Example*], [*Weight*], [*Style*], [*Family*], [*Case*]),

  [*Scalar*], $ss(s)$, [Regular], [Italic], [Serif], [Lower],
  [*Vector*], $vv(v)$, [Bold], [Italic], [Serif], [Lower],
  [*Matrix*], $mm(M)$, [Bold], [Upright], [Serif], [Upper],
  [*Tensor*], $tt(T)$, [Bold], [Upright], [Sans], [Upper],
))

This has the distinct advantage that each object type can be uniquely determined from the style
without requiring the correct case to be used. This is neat, since in many fields the case of
the symbol does not necessarily reflect its mathematical meaning. For example, the magnetic field _vector_ is often denoted $vv(B)$, which is unambiguously a vector here given that it is both bold and italicised.

It is still somewhat difficult to discern tensors and matrices given that these are only distinguished by the presence of serifs on matrices.

== Criticism

It does not follow the ISO 80000-2 convention, which is a shame, but neither does anyone else, so there is that.

Additionally, I find that the mismatched style (italics/upright) between vectors and matrices is somewhat jarring to look at.
