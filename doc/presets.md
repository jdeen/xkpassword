# Presets

Back to the [docs index](README.md) or the [project README](../README.md).

`XKPassword.generate` and `XKPassword::Generator#generate` accept a `:preset` option.
If omitted, `:preset` defaults to `:xkcd`.

## Supported presets

| Preset | Defaults |
| --- | --- |
| `:xkcd` | 4 words, 4-8 letters, `-` separator, random per-word uppercasing |
| `:web32` | 4 words, 4-5 letters, `-` separator, random per-word uppercasing |
| `:wifi` | 6 words, 4-8 letters, `-` separator, random per-word uppercasing |
| `:security` | 6 words, 4-8 letters, space separator, lowercase words |
| `:apple_id` | 3 words, 4-7 letters, `-` separator, random per-word uppercasing |

## Examples

```ruby
require 'xkpassword'

XKPassword.generate
XKPassword.generate(preset: :wifi)
XKPassword.generate(preset: :security, separator: '.')
```

You can pass a preset as a symbol or string. String values like `"apple_id"` and `"apple-id"`
are normalized to the matching preset.

Explicit options always win over the preset defaults, so this is valid:

```ruby
XKPassword.generate(preset: :xkcd, words: 6, case_transform: :capitalize)
```

For the full source and latest updates, see the [GitHub repository](https://github.com/jdeen/xkpassword).
