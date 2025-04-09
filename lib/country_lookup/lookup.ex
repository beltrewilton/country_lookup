defmodule CountryLookup do
  use GenServer

  # Starts the GenServer and loads the data into state
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(_) do
    data = CountryLookup.Loader.load_data()
    {:ok, data}
  end

  @doc """
  Lookup by area code (e.g., "7840", "93", "35818").
  Returns a map: %{name: ..., flag_svg: ...} or nil if not found.
  """
  def lookup_by_code(code) when is_binary(code) do
    GenServer.call(__MODULE__, {:lookup, code})
  end

  @doc """
  Search countries by (partial) name, case-insensitive.
  Returns a list of maps: [%{name: ..., flag_image: ...}, ...]
  """
  def search_by_name(query) when is_binary(query) do
    GenServer.call(__MODULE__, {:search, query})
  end

  def handle_call({:lookup, number}, _from, state) do
    match =
      state
      |> Enum.filter(fn %{"dial_codes" => codes} ->
        Enum.any?(codes, fn code -> String.starts_with?(number, code) end)
      end)
      |> Enum.sort_by(
        fn %{"dial_codes" => codes} ->
          codes
          |> Enum.filter(&String.starts_with?(number, &1))
          |> Enum.map(&String.length/1)
          |> Enum.max()
        end,
        :desc
      )
      |> List.first()

    result =
      case match do
        %{"name" => name, "flag_image" => flag_image} -> %{name: name, flag_image: flag_image}
        _ -> nil
      end

    {:reply, result, state}
  end

  def handle_call({:search, query}, _from, state) do
    matches =
      state
      |> Enum.filter(fn %{"name" => name} ->
        String.contains?(String.downcase(name), String.downcase(query))
      end)
      |> Enum.map(fn %{"name" => name, "flag_image" => flag_image, "dial_codes" => dial_codes} ->
        %{name: name, flag_image: flag_image, dial_codes: dial_codes}
      end)

    {:reply, matches, state}
  end
end
