#import "@preview/semantrix:0.1.0": object, set_

#let bra = object("bra", "custom")
#let ket = object("ket", "custom")

#show: set_(bra, wrap: ("⟨", "|"))
#show: set_(ket, wrap: ("|", "⟩"))

$
  bra(ψ), ket(ψ)
$