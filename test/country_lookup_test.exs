defmodule CountryLookupTest do
  use ExUnit.Case
  doctest CountryLookup

  test "greets the world" do
    assert CountryLookup.hello() == :world
  end
end
