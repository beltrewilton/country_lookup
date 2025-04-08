# CountryLookup

A lightweight Elixir library for identifying countries by their telephone dialing codes. Given a phone number or area code, country_lookup returns the matching country name and its flag as an inline image/base64.

### ✨ Features
🔍 Fast lookup using prefix matching (longest match wins)

📞 Supports country calling codes, including national variants (e.g. 1809, 55)

🏳️ Flag images embedded as Base64-encoded SVG

🔌 Designed for easy integration with Phoenix LiveView or CLI apps

📁 Automatically downloads and parses latest data from Wikipedia



## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `country_lookup` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:country_lookup, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/country_lookup>.

