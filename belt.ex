defmodule Belt do
  defmacro __using__ _opts do
    quote do
      import Belt
    end
  end

  require Logger

  def any? enumerable, fun do Enum.any? enumerable, fun end

  def all? enumerable, fun do Enum.all? enumerable, fun end

  def at enumberable, index do Enum.at enumberable, index end

  def drop enumerable, n do Enum.drop enumerable, n end

  def each enumerable, fun do Enum.each enumerable, fun end

  def empty? "" do true end
  def empty? nil do true end
  def empty? enumerable do Enum.empty? enumerable end

  def filter enumerable, fun do Enum.filter enumerable, fun end

  def first enumerable do at enumerable, 0 end

  def flatten enumerable do List.flatten enumerable end

  def find enumerable, fun do Enum.find enumerable, fun end

  def find_index(enumerable, value) when not is_function(value) do
    Enum.find_index enumerable, fn(v) -> v == value end
  end
  def find_index enumerable, fun do Enum.find_index enumerable, fun end

  @doc """
  Returns value from map if it exists or returns the default value and updated map
  with the new entry.

    iex> Belt.get_or_create %{}, :a, fn() -> 0 end
    {%{a: 0}, 0}

    iex> map = %{a: 0}
    iex> Belt.get_or_create map, :b, fn() -> 1 end
    {%{a: 0, b: 1}, 1}
  """
  def get_or_create(map, key, fun) when is_function(fun, 0) do
    case map[key] do
      nil ->
        default = fun.()
        {put(map, key, default), default}
      value -> {map, value}
    end
  end

  @doc """
  Returns value from map if it exists or returns the default value and updated map
  with the new entry.

    iex> Belt.get_or_create %{}, :a, 0
    {%{a: 0}, 0}

    iex> map = %{a: 0}
    iex> Belt.get_or_create map, :b, 1
    {%{a: 0, b: 1}, 1}
  """
  def get_or_create(map, key, default) do Belt.get_or_create(map, key, fn() -> default end) end

  def has?(%MapSet{} = set, key) do MapSet.member? set, key end
  def has?(map, key) when is_map(map) do Map.has_key? map, key end
  def has?(enumerable, key) do key in enumerable end

  def into(enumerable, collectable) do Enum.into enumerable, collectable end

  def join list, joiner \\ "" do Enum.join list, joiner end

  def keys(map) when is_list(map) do Keyword.keys map end
  def keys map do Map.keys map end

  def log level, msg do Logger.log level, msg end

  def map enumerable, fun do Enum.map enumerable, fun end

  def map_reduce enumerable, acc, fun do Enum.map_reduce enumerable, acc, fun end

  def matches? regex, string do Regex.match? regex, string end

  def merge %{} = map1, %{} = map2 do Map.merge map1, map2 end
  def merge(%{} = map1, map2) when is_list(map2) do merge map1, Enum.into(map2, %{}) end

  def put(%MapSet{} = set, key, value) do MapSet.put set, key, value end
  def put(map, keys, value) when is_list(keys) do put_in map, keys, value end
  def put map, key, value do Map.put map, key, value end

  def p msg do IO.puts inspect msg end
  def p msg1, msg2 do IO.puts inspect {msg1, msg2} end
  def p msg1, msg2, msg3 do IO.puts inspect {msg1, msg2, msg3} end
  def p msg1, msg2, msg3, msg4 do IO.puts inspect {msg1, msg2, msg3, msg4} end

  def reduce enumerable, acc, fun do Enum.reduce enumerable, acc, fun end

  def reject enumerable, fun do Enum.reject enumerable, fun end

  def replace(subject, pattern, replacement) when is_binary(pattern) do
    replace subject, Regex.compile!(Regex.escape(pattern)), replacement
  end
  def replace subject, pattern, replacement do Regex.replace pattern, subject, replacement end

  def reverse enumerable do Enum.reverse enumerable end

  def size(data) when is_bitstring(data) do bit_size data end
  def size(data) when is_binary(data) do byte_size data end
  def size(data) when is_binary(data) do byte_size data end
  def size(data) when is_map(data) do map_size data end
  def size(data) when is_tuple(data) do tuple_size data end

  def scan string, regex do Regex.scan regex, string end

  def slice(enumerable, range) do Enum.slice enumerable, range end
  def slice(enumerable, start, count) do Enum.slice enumerable, start, count end

  def sort enumerable, fun do Enum.sort enumerable, fun end
  def sort enumerable do Enum.sort enumerable end

  def sort_by enumerable, mapper, sorter \\ &<=/2 do Enum.sort_by enumerable, mapper, sorter end

  def split string, pattern do String.split string, pattern end

  def take enumerable, count do Enum.take enumerable, count end

  def to_list(map) when is_map(map) do Map.to_list map end
  def to_list(list) when is_list(list) do list end

  def uniq enumerable do Enum.uniq enumerable end

  def values(map) when is_list(map) do Keyword.values map end
  def values map do Map.values map end

  def with_index enumerable, offset \\ 0 do Enum.with_index enumerable, offset end

  def zip enumerable1, enumerable2 do Enum.zip enumerable1, enumerable2 endnd
end
