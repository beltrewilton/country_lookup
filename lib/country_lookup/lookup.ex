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

  def handle_call({:lookup, number}, _from, state) do
    match =
      state
      |> Enum.filter(fn %{"dial_codes" => codes} ->
        Enum.any?(codes, fn code -> String.starts_with?(number, code) end)
      end)
      |> Enum.sort_by(fn %{"dial_codes" => codes} ->
        codes
        |> Enum.filter(&String.starts_with?(number, &1))
        |> Enum.map(&String.length/1)
        |> Enum.max()
      end, :desc)
      |> List.first()
  
    result =
      case match do
        %{"name" => name, "flag_image" => flag_image} -> %{name: name, flag_image: flag_image}
        _ -> nil
      end
  
    {:reply, result, state}
  end
end
