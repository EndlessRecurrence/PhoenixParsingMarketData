defmodule Currencies.Top do
  @moduledoc "A Mix task retrieving the top x currencies by a specified property"

  def read_objects_from_json_file() do
    {status, contents} = File.read("assets/objects.json")
    case status do
      :ok ->
        {decoding_status, objects} = JSON.decode(contents)
        if decoding_status == :ok, do: objects, else: raise RuntimeError, message: "JSON file could not be decoded."
      _ -> raise RuntimeError, message: "JSON file containing the objects could not be read, because it doesn't exist."
    end
  end

  def retrieve_top_currencies_by_property(property, number_of_currencies) do
    read_objects_from_json_file()
    |> Enum.sort(fn x, y ->
      if is_bitstring(x[property]), do: x[property] > y[property], else: abs(x[property]) > abs(y[property])
    end)
    |> Enum.take(number_of_currencies)
  end

  def run(args) do
    {incorrect_tokens, correct_tokens} = ArgParsing.process_arguments(args)
    allowed_arguments = ["count", "column"]
    Enum.each(incorrect_tokens, &IO.puts("ERROR: The argument \"#{&1}\" is incorrectly formated."))
    Enum.each(correct_tokens, fn x ->
      if not Enum.member?(allowed_arguments, Enum.at(x, 0)), do:
        IO.puts("ERROR: The argument \"#{x}\" is not specified in the documentation.")
    end)

    argument_validity = ArgParsing.are_arguments_allowed?(allowed_arguments, correct_tokens)
    if incorrect_tokens == [] and length(correct_tokens) == 2 and argument_validity do
      count = correct_tokens
        |> ArgParsing.get_argument_value_by_name("count")
        |> ArgParsing.parse_string()
      column = ArgParsing.get_argument_value_by_name(correct_tokens, "column")
      retrieve_top_currencies_by_property(column, count)
    end
  end
end
