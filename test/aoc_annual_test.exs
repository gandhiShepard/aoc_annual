defmodule AocAnnualTest do
  use ExUnit.Case
  doctest AocAnnual

  test "greets the world" do
    assert AocAnnual.hello() == :world
  end
end
