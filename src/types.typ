
#import "@preview/elembic:1.1.1"
#import "const.typ": (
  MATCHED_DELIMITERS as __MATCHED_DELIMITERS,
  FENCES as __FENCES,
)

#let is-delimiter(char) = {
  if type(char) == str {
    return char in __MATCHED_DELIMITERS.keys() or char in __MATCHED_DELIMITERS.values() or char in __FENCES
  } else if type(char) == symbol {
    return is-delimiter(str(char))
  }
  return false
}

#let pos-int-type = elembic.types.wrap(
  int,
  name: "positive-integer",
  check: old-check => value => value > 0
)

#let tuple-type(..args) = {
  assert(args.named() == (:), message: "tuple-type does not take named arguments")
  let types = args.pos()

  let n = types.len()
  let type-infos = types.map(t => {
    let (success, typeinfo) = elembic.types.typeinfo(t)
    assert(success, message: "Invalid type provided to tuple-type: " + repr(t))
    return typeinfo
  })
  let name = ("tuple:" + type-infos.map(t => t.name).join("--"))

  let validator = value => {
    if type(value) != array { return ("must be an array", false) }
    if value.len() != n { return ("must have " + str(n) + " elements", false) }
    for (i, (type, instance)) in types.zip(value).enumerate() {
      let (success, out) = elembic.types.cast(instance, type)
      // Out is error message if success == false, otherwise it is the casted value
      if not success { return ("element " + str(i) + " is invalid: " + out , false) }
    }
    return (none, true)
  }

  let new-type = elembic.types.wrap(
    elembic.types.array(elembic.types.union(..types)),
    name: name,
    fold: none,
    check: old-check => value => validator(value).at(1),
    error: old-error => value => validator(value).at(0),
  )

  return new-type
}

#let delim-type = elembic.types.wrap(
  elembic.types.union(str, symbol),
  name: "delimiter",
  check: old-check => value => is-delimiter(value)
)

#let delim-like-type = tuple-type(delim-type, delim-type)
