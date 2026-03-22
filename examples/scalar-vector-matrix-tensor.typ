#import "@preview/semantrix:0.1.0": object, vv, mm, set_

// Second argument can be one of "scalar", "vector", "matrix", "tensor", or "custom". This determines which presets are available.
#let ss = object("ss", "scalar")
#let tt = object("tt", "tensor")

#show: set_(ss, vv, mm, tt, preset: "ISO")

$
  ss(s), vv(v), mm(M), tt(T)
$


