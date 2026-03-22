#let PRESET_ALIASES = (
  "ISO": "ISO 80000-2",
)

// The default preset for each object type.
#let DEFAULT_PRESETS = (
  "scalar": "ISO 80000-2",
  "vector": "ISO 80000-2",
  "matrix": "ISO 80000-2",
  "tensor": "ISO 80000-2",
  "custom": "default",
)

// Options dictionary as seen by presets
// Required: weight, style, family
// Optional: above, below, underlines, wrap, custom, extra
// -- These are resolved from DEFAULT_OPTIONS if not present
#let DEFAULT_OPTIONS = (
  above: none,
  below: none,
  underlines: 0,
  wrap: none,
  custom: none,
  extra: (:),
)

// Some predefined easy-to-reference presets with common names
#let UNIVERSAL_PRESETS = (:)
// Dynamically construct base universal presets
#{
  for weight in ("regular", "bold") {
  for style in ("upright", "italic") {
  for family in ("serif", "sans") {
    let key = (weight, style, family).join("-")
    let value = (
      "weight": weight,
      "style": style,
      "family": family,
    )

    UNIVERSAL_PRESETS.insert(key, value)
  }}}
}
#UNIVERSAL_PRESETS.insert("base", UNIVERSAL_PRESETS.at("regular-italic-serif"))

// Note: would make more sense to swap order of 'object' and 'convention' for human intuition, but does not fit data access pattern well.
// (object: (preset: options-or-ref))
// In the above, option-or-ref can either be an option dictionary or a string referring to a universal preset
)
#let PRESETS = (
  "scalar": (
    "ISO 80000-2": "regular-italic-serif",
    "semantrix": "regular-italic-serif",
    "IEEE": "regular-italic-serif",
    "APA": "regular-italic-serif",
    "Nature": "regular-italic-serif",
    "APS": "regular-italic-serif",
    "AIP": "regular-italic-serif",
    "AMS": "regular-italic-serif",
    "handwritten": "regular-italic-serif",
  ),
  "vector": (
    "ISO 80000-2": "bold-italic-serif",
    "semantrix": "bold-italic-serif",
    "IEEE": "bold-upright-serif",
    "APA": "bold-upright-serif",
    "Nature": "bold-upright-serif",
    "APS": "bold-upright-serif",
    "AIP": "bold-italic-serif",
    "AMS": "regular-italic-serif",
    "handwritten": (
      "weight": "bold",
      "style": "italic",
      "family": "serif",
      "underlines": 1,
    ),
    "arrow": (
      "weight": "regular",
      "style": "italic",
      "family": "serif",
      "above": "arrow",
    ),
    "underline": (
      "weight": "regular",
      "style": "italic",
      "family": "serif",
      "underlines": 1,
    ),
    "undertilde": (
      "weight": "regular",
      "style": "italic",
      "family": "serif",
      "below": "tilde",
    ),
    "overline": (
      "weight": "regular",
      "style": "italic",
      "family": "serif",
      "above": "line",
    ),
  ),
  "matrix": (
    "ISO 80000-2": "bold-italic-serif",
    "semantrix": "bold-upright-serif",
    "IEEE": "bold-upright-serif",
    "APA": "bold-upright-serif",
    "Nature": "bold-upright-serif",
    "APS": "bold-upright-sans",
    "AIP": "bold-upright-sans",
    "AMS": "regular-italic-serif",
    "handwritten": (
      "weight": "bold",
      "style": "italic",
      "family": "serif",
      "underlines": 2,
    ),
    "underline": (
      "weight": "bold",
      "style": "italic",
      "family": "serif",
      "underlines": 2,
    ),
  ),
  "tensor": (
    "ISO 80000-2": "bold-italic-sans",
    "semantrix": "bold-upright-sans",
    "IEEE": "bold-upright-serif",
    "APA": "bold-upright-serif",
    "Nature": "bold-upright-serif",
    "APS": "bold-upright-sans",
    "AIP": "bold-upright-sans",
    "AMS": "regular-italic-serif",
    "handwritten": (
      "weight": "bold",
      "style": "italic",
      "family": "serif",
      "below": "tilde",
    ),
    "undertilde": (
      "weight": "bold",
      "style": "upright",
      "family": "serif",
      "below": "tilde",
    ),
  ),
  "custom": (
    "default": "regular-italic-serif",
  ),
)

// Update PRESETS with the universal preset names
#let _universal_preset_aliases = (:)
#for alias in UNIVERSAL_PRESETS.keys() {
  _universal_preset_aliases.insert(alias, alias)
}
#for object in PRESETS.keys() { PRESETS.at(object) += _universal_preset_aliases }

// Silly tests to check presets are ok
#let __DEV_DEBUG = true
#if __DEV_DEBUG {
  for (object, presets) in PRESETS {

    for (preset, options) in presets {
      if type(options) == str {
        assert(options in UNIVERSAL_PRESETS.keys())
      } else if type(options) == dictionary {
        for required in ("weight", "style", "family") {
          assert(required in options.keys(), message: "missing required option '" + required + "' in preset " + preset)
        }

        for (k, v) in options.pairs() {
          assert(v != auto, message: "option '" + k + "' set to auto for preset " + preset)
        }
      }
    }
  }
}