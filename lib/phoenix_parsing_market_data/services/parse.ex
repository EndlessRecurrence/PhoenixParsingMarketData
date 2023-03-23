defmodule Currencies.Parse do
  @moduledoc """
    A Mix.Task which parses a file containing currency data.
  """

  def create_json_file_containing_market_data_as_objects(filepath) do
    {:ok, file} = File.open("assets/objects.json", [:write])
    {status, result} = filepath
      |> convert_file_data_into_objects()
      |> JSON.encode()

    case status do
      :ok ->
        filewrite_status = IO.binwrite(file, result)
        if filewrite_status != :ok, do: raise RuntimeError, message: "Writing the JSON objects to the file failed."
      _ -> raise RuntimeError, message: "Encoding the file objects as JSON failed."
    end
  end

  def convert_file_data_into_objects(filepath) when is_bitstring(filepath) do
    try do
      [properties | data] = read_data_as_text_from_file(filepath)
      create_objects_as_maps(data, properties, [])
    rescue
      _e in MatchError -> raise RuntimeError, message: "The file is empty."
    end
  end
  def convert_file_data_into_objects(_), do:
    raise ArgumentError, message: "The input to convert_file_data_to_objects should be a filepath string."

  def read_data_as_text_from_file(path) do
    try do
      lines =
        path
        |> File.stream!()
        |> Enum.map(&String.trim/1)

      lines |> Enum.map(&split_line_into_tokens(&1))
    rescue
      _e in File.Error -> raise RuntimeError, message: "The file doesn't exist."
    end
  end

  def split_line_into_tokens(line) when is_bitstring(line) do
    Regex.split(~r/\s+/, line)
  end
  def split_line_into_tokens(_), do: raise ArgumentError, message: "The input to split_line_into_tokens should be a BitString."

  def create_objects_as_maps([], _, objects), do: objects
  def create_objects_as_maps([list | lists], properties, objects) do
    object = Enum.zip(0..length(properties), list)
      |> Enum.map(fn {index, value} -> {Enum.at(properties, index), ArgParsing.parse_string(value)} end)
      |> Enum.into(%{})
    create_objects_as_maps(lists, properties, [object | objects])
  end

  def handle_float_precision_of_object_properties(object, precision) do
    object
      |> Enum.map(fn {x, y} ->
        cond do
          is_float(y) -> {x, Float.round(y, precision)}
          true -> {x, y}
        end
      end)
      |> Enum.into(%{})
  end

  def handle_float_precision_for_objects(objects, precision) do
    objects |> Enum.map(&handle_float_precision_of_object_properties(&1, precision))
  end

  def run(args) do
    dbg(args)
    {incorrect_tokens, correct_tokens} = ArgParsing.process_arguments(args)
    dbg(incorrect_tokens)
    dbg(correct_tokens)
    allowed_arguments = ["path"]
    Enum.each(incorrect_tokens, &IO.puts("ERROR: The argument \"#{&1}\" is incorrectly formated."))
    Enum.each(correct_tokens, fn x ->
      if Enum.at(x, 0) != "path", do:
        IO.puts("ERROR: The argument \"#{x}\" is not specified in the documentation.")
    end)

    if incorrect_tokens == [] and length(correct_tokens) == 1 do
      arg_value = correct_tokens |> Enum.at(0) |> Enum.at(1)
      dbg(arg_value)
      if ArgParsing.are_arguments_allowed?(allowed_arguments, correct_tokens) do
        create_json_file_containing_market_data_as_objects(arg_value)
      end
    end
  end
end
