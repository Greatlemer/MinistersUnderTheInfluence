defmodule DataLayoutsContext do
  @moduledoc """
  Step functions for the data_layouts.feature file.
  """

  use WhiteBread.Context

  given_ ~r/a data file named "(?<file_name>[^"]+)" from the "(?<office_name>[^"]+)" containing/,
  fn state, matches ->
    new_state = state
      |> Map.put(:file_name, matches.file_name)
      |> Map.put(:office_name, matches.office_name)
      |> Map.put(:file_contents, matches.doc_string)
    {:ok, new_state}
  end

  when_ ~r/^the file is processed$/,
  fn state ->
    file_metadata = new_file_metadata filename: state.file_name,
                                      department: state.office_name
    cleaned_data = state.file_contents
      |> parse_and_clean_rows(file_metadata)
      |> convert_to_csv_output(file_metadata)
    new_state = state
      |> Map.put(:cleaned_data, cleaned_data)
    {:ok, new_state}
  end

  then_ ~r/^the cleaned output should be$/,
  fn state, %{doc_string: expected_output} ->
    assert expected_output == state.cleaned_data
    {:ok, state}
  end


  ## Helper Functions

  defp parse_and_clean_rows(file_data, file_metadata) do
    file_data
      |> String.split("\n")
      |> DataSanitiser.CSVCleaner.CSVParser.parse_stream(headers: false)
      |> Stream.with_index
      |> DataSanitiser.FileProcessor.clean_data(file_metadata)
  end

  defp new_file_metadata(options) do
    default_metadata = %DataSanitiser.TransparencyData.DataFile{
      name: "Some Name",
      filename: "Some Filename",
      department: "Some Department",
      title: "Some File",
      date_published: "2017-02-10T00:00:00+00:00",
      source_url: "http://example.com",
      data_type: :meetings,
      file_type: :csv,
    }
    options
      |> Enum.reject(fn {_, value} -> value == :nil end)
      |> Enum.reduce(
           default_metadata,
           fn {key, val}, metadata -> Map.put(metadata, key, val) end
         )
  end

  defp convert_to_csv_output(rows, file_metadata) do
    file_metadata
      |> Map.put(:rows, rows)
      |> wrap_as_ok
      |> DataSanitiser.TransparencyData.DataFile.stream_clean_rows_to_csv(1)
      |> tuple_first
      |> DataSanitiser.CSVCleaner.CSVParser.dump_to_iodata
      |> IO.iodata_to_binary
  end

  defp wrap_as_ok(thing), do: {:ok, thing}

  defp tuple_first({first, _}), do: first
end
