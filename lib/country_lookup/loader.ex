defmodule CountryLookup.Loader do
  @json_path Path.join(File.cwd!(), "data/country_dial_data.json")

  def load_data do
    with {:ok, body} <- File.read(@json_path),
         {:ok, json} <- Jason.decode(body) do
      IO.inspect(@json_path, label: "@json_path")
      json
    else
      _ -> 
      IO.inspect(@json_path, label: "@json_path")
      []
    end
  end
end
