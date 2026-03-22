#import "@preview/elembic:1.1.1" as elembic: field, types
#import "presets.typ": (
  PRESETS,  // We 'reexport' this
  PRESET_ALIASES as __PRESET_ALIASES,
  DEFAULT_OPTIONS as __DEFAULT_OPTIONS,
  DEFAULT_PRESETS as __DEFAULT_PRESETS,
  UNIVERSAL_PRESETS as __UNIVERSAL_PRESETS,
)
#import "utils.typ": (
  ez-attach as __ez-attach,
  underlines as __underlines,
  BELOW_ACCENT_CONTENTS as __BELOW_ACCENT_CONTENTS
)
#import "const.typ": (
  MATH_STYLES as __MATH_STYLES,
  MATH_FAMILIES as __MATH_FAMILIES,
  ABOVE_MATH_ACCENTS as __ABOVE_MATH_ACCENTS,
  BELOW_MATH_ACCENTS as __BELOW_MATH_ACCENTS,
  MATCHED_DELIMITERS as __MATCHED_DELIMITERS,
  FENCES as __FENCES,
)
#import "types.typ": (
  is-delimiter as __is-delimiter,
  pos-int-type as __pos-int-type,
  tuple-type as __tuple-type,
  delim-type as __delim-type,
  delim-like-type as __delim-like-type,
)

#let _resolve_options(
  it
) = {
  let _resolved_preset_name = __PRESET_ALIASES.at(it.preset, default: it.preset)
  let preset = PRESETS.at(it.__object).at(_resolved_preset_name)
  // Preset can be a reference to a universal preset, so we need to resolve that as well
  if type(preset) == str {
    preset = __UNIVERSAL_PRESETS.at(preset)
  }

  let set_fields = elembic.fields(it)

  _ = set_fields.remove("__object")
  _ = set_fields.remove("body")
  _ = set_fields.remove("preset")

  // Remove auto fields since these will just be given by the preset after dict merge
  for (k, v) in set_fields.pairs() {
    if v == auto { _ = set_fields.remove(k) }
  }

  let resolved_fields = (: ..__DEFAULT_OPTIONS, ..preset, ..set_fields)

  // Resolve aliases, was previously a big loop over arrays with a constant aliases dictionary,
  // but this is inefficient and does not work with non-string values
  // This seems inelegant, but it is actually not if you don't think about, or maybe if you do. Don't.
  // Below have been changed but are left as inspiration for next aliases
  // if resolved_fields.at("above") == "arrow" { resolved_fields.at("above") = "arrow.r" }
  // if resolved_fields.at("below") == "arrow" { resolved_fields.at("below") = "arrow.r" }

  // Resolve symbols in wrap option
  if type(resolved_fields.wrap) == symbol { resolved_fields.at("wrap") = str(resolved_fields.wrap) }
  else if type(resolved_fields.wrap) == array {
    resolved_fields.at("wrap") = resolved_fields.wrap.map(x => if type(x) == symbol { str(x) } else { x})
  }

  // Check for option incompatibilities
  if resolved_fields.at("underlines") != 0 and resolved_fields.at("below") != none { panic("Cannot use 'underlines' with 'below' ")}

  return resolved_fields
}

#let _display_object(it) = {
  let options = _resolve_options(it)
  let symbol = it.body

  // Weight
  if options.weight == "bold" { symbol = math.bold(symbol) }

  // Style
  if options.style == "italic" {
    symbol = math.italic(symbol)
  } else if options.style == "upright" {
    symbol = math.upright(symbol)
  } else if options.style == none {
    // No-op, having this is an option allows users to override a particular preset to the default style of the document, i.e. we don't _apply_ a style in this case.
  } else { panic("this is a bug!") }

  // Family (variant in Typst language?)
  if options.family in __MATH_FAMILIES.keys() {
    symbol = __MATH_FAMILIES.at(options.family)(symbol)
  } else if options.family == none {
    // No-op, see above
  } else { panic("this is a bug!") }

  // Above
  let above-attachment = none  // For attaching content, should be done in a single attach command
  if type(options.above) == str  {
    if options.above in __ABOVE_MATH_ACCENTS.keys() {
      let _accent-symbols = (__ABOVE_MATH_ACCENTS.at(options.above), ).flatten() // Ensure it is a flat array of symbols
      symbol = _accent-symbols.fold(symbol, (acc, x) => math.accent(acc, x))
    } else { panic("this is a bug!") }
  } else if type(options.above) == content {
    above-attachment = options.above
  } else if options.above == none {
    // No-op, see above
  } else { panic("this is a bug!") }

  // Below
  let below-attachment = none
  if type(options.below) == str {
    if options.below in __BELOW_MATH_ACCENTS.keys() {
      let _accent-symbols = (__BELOW_MATH_ACCENTS.at(options.below), ).flatten() // Ensure it is a flat array of symbols
      symbol = _accent-symbols.fold(symbol, (acc, x) => math.accent(acc, x))
    } else { panic("this is a bug!") }
  } else if type(options.below) == content {
    below-attachment = options.below
  } else if options.below == none {
    // No-op, see above
  } else { panic("this is a bug!") }

  // Do attachments
  symbol = __ez-attach(symbol, t: above-attachment, b: below-attachment)

  // Underlines
  symbol = __underlines(symbol, options.underlines)

  // Wrap
  // Note: symbols have already been resolved in _resolve_options
  // assert(false, message: options.wrap)
  if options.wrap == none {
    // No-op, see above
  } else {
    let left = none
    let right = none

    if type(options.wrap) == str {
      assert(__is-delimiter(options.wrap)) // Should not be needed, remove later for perf
      left = options.wrap

      if options.wrap in __MATCHED_DELIMITERS.keys() {
        right = __MATCHED_DELIMITERS.at(options.wrap)
      } else if options.wrap in __MATCHED_DELIMITERS.values() {
        right = options.wrap
      } else if options.wrap in __FENCES {
        left = options.wrap
        right = options.wrap
      } else { panic("this is a bug!") }
    } else if type(options.wrap) == array {
      assert(options.wrap.len() == 2, message: "wrap option array must have 2 elements")
      left = options.wrap.at(0)
      right = options.wrap.at(1)
    } else { panic("this is a bug!") }
      // We need to remap to symbols to get correct left-right stretching
      // See: https://discord.com/channels/1054443721975922748/1088371919725793360/1482396829911093389
      left = std.symbol(left)
      right = std.symbol(right)
      symbol = $lr(left symbol right)$
    }

  // Custom
  if type(options.custom) == function {
    symbol = options.custom(symbol, options)
  } else if options.custom == none {
    // No-op, see above
  } else { panic("this is a bug!") }

  return symbol
}

#let object(name, object, ..default-fields) = elembic.element.declare(
  name,
  prefix: "@preview/semantrix:object,v1",
  doc: "A semantically encoded mathematical object (vector, matrix, tensor, scalar, or custom).",
  labelable: false,
  reference: none,
  display: _display_object,
  fields: (
    field(
      "__object",
      types.union("scalar", "vector", "matrix", "tensor", "custom"),
      doc: "This just determines which presets we look at.",
      default: object,
      internal: true
    ),
    field(
      "body",
      content,
      doc: "Symbol body.",
      required: true
    ),
    field(
      "preset",
      types.union(..(..__PRESET_ALIASES.keys(), ..PRESETS.at(object).keys())),
      doc: "A preset convention to use.",
      default: default-fields.at("preset", default: __DEFAULT_PRESETS.at(object))
    ),
    field(
      "weight",
      types.smart(types.union("bold", "regular")),
      doc: "Weight of symbol.",
      default: default-fields.at("weight", default: auto)
    ),
    field(
      "style",
      types.smart(types.union(none, "upright", "italic")),
      doc: "Style of symbol.",
      default: default-fields.at("style", default: auto)
    ),
    field(
      "family",
      types.smart(types.union(none, ..__MATH_FAMILIES.keys())),
      doc: "Font family of symbol.",
      default: default-fields.at("family", default: auto)
    ),
    field(
      "above",
      types.smart(types.union(none, ..__ABOVE_MATH_ACCENTS.keys(), content)),
      doc: "Accent placed above symbol.",
      default: default-fields.at("above", default: auto)
    ),
    field(
      "below",
      types.smart(types.union(none, ..__BELOW_MATH_ACCENTS.keys(), content)),
      doc: "Accent placed below symbol.",
      default: default-fields.at("below", default: auto)
    ),
    field(
      "underlines",
      types.smart(__pos-int-type),
      doc: "Number of bars placed under symbol. Cannot be used with 'below'.",
      default: default-fields.at("underlines", default: auto)
    ),
    field(
      "wrap",
      types.smart(types.union(__delim-type, __delim-like-type)),
      doc: "Wraps symbol in a delimiters",
      default: default-fields.at("wrap", default: auto),
    ),
    field(
      "custom",
      types.smart(types.union(function, none)),
      doc: "A custom display function that takes `(symbol, options)` and returns a new `symbol`. Applied last.",
      default: default-fields.at("custom", default: auto)
    ),
    field(
      "extra",
      types.smart(dictionary),
      doc: "A dictionary for storing any extra information that custom functions might need",
      default: default-fields.at("extra", default: auto)
    ),
  )
)

#let vv = object("vv", "vector")
#let mm = object("mm", "matrix")

/// Sets fields (such as the preset field) on all object(s)
///
/// ```example
/// #set_(vv, ss, preset: "IEEE")
///
/// -> function
#let set_(
  /// Positional args are assumed to be objects (instances of `semantrix`)
  /// Named args are the fields to be set on those objects
  ..args,
  /// If true, preset failures will not throw an error, but will instead just not apply the preset. This is useful for presets that are only meant to be used in specific contexts, such as the 'arrow' preset which relies on the presence of specific accents that may not be present in all math fonts.
  quiet-preset-failure: false,
) = {
  let objects = args.pos()
  let fields = args.named()

  assert(objects.len() > 0, message: "set_ requires at least one positional argument")

  // Check that all positional arguments are elembic elements
  for object in objects { assert(elembic.data(object).data-kind == "element", message: "Positional arguments must be semantrix objects, was: " + repr(object)) }

  // Construct rules
  let rules = ()
  for object in objects {
    let resolved_fields = fields
    // Quietly fail presets
    if "preset" in fields.keys() and quiet-preset-failure {
      let preset = fields.preset
      let preset-typeinfo = elembic.data(object).fields.all-fields.preset.typeinfo
      let (success, _) = elembic.types.cast(preset, preset-typeinfo)

      if not success {
        _ = resolved_fields.remove("preset")
      }
    }

    rules.push(elembic.set_(object, ..resolved_fields))
  }

  return elembic.apply(..rules)
}
