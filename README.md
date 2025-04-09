# CountryLookup

A lightweight Elixir library for identifying countries by their telephone dialing codes. Given a phone number or area code, or country name, country_lookup returns the matching country name and its flag as an inline image/base64.

## Usage

```elixir
iex> CountryLookup.lookup_by_code("55")
%{
  name: "Brazil",
  flag_image: "iVBORw0KGgoAAAANSUhEUgAAA..."
}


iex> CountryLookup.search_by_name("Domini")
[
  %{
    name: "Dominica",
    flag_image: "iVBORw0KGgoAAAAN...",
    dial_codes: ["1767"]
  },
  %{
    name: "Dominican Republic",
    flag_image: "iVBORw0KGgoAAAANSUhEU...",
    dial_codes: ["1809", "1829", "1849"]
  }
]
```

### ✨ Features
🔍 Fast lookup using prefix matching (longest match wins)

📞 Supports country calling codes, including national variants (e.g. 1809, 55), also search by country name.

🏳️ Flag images embedded as Base64-encoded PNGs.

🔌 Designed for easy integration with Phoenix LiveView or CLI apps

📁 (Optional) Keep update with latest data from Wikipedia (Python):
```shell
conda create -n country_lookup_env python=3.10
conda activate country_lookup_env
conda install requests beautifulsoup4 pillow cairosvg
cd python_skrap;
# scrape data from Wikipedia
python skrap.py 
```



## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `country_lookup` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:country_lookup, "~> 0.0.2"}
  ]
end
```

And configure your `application.ex`:

```elixir
@impl true
def start(_type, _args) do
  children = [
    ...
    CountryLookup
  ]
```


Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/country_lookup>.

