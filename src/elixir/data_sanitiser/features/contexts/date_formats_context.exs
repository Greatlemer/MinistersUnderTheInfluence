defmodule DateFormatsContext do
  @moduledoc """
  Step functions for the data_formats.feature file.
  """

  use WhiteBread.Context

  given_ ~r/^the string "(?<date_string>[^"]+)" to represent a date$/,
  fn state, %{date_string: date_string} ->
    {
      :ok,
      Map.put(state, :date_string, date_string)
    }
  end

  given_ ~r/^a default year of (?<default_year>\d{4}|nil)$/,
  fn state, %{default_year: default_year} ->
    {
      :ok,
      Map.put(state, :default_year, default_year)
    }
  end

  when_ ~r/^that string is parsed$/,
  fn state ->
    {
      :ok,
      Map.put(
        state,
        :parsed_date,
        parse_date(state.date_string, Map.get(state, :default_year))
      )
    }
  end

  then_ ~r/^we get "(?<day>[^"]+)", "(?<month>[^"]+)", "(?<year>[^"]+)" extracted from it$/,
  fn state, %{day: expected_day, month: expected_month, year: expected_year} ->
      with %{day: day, month: month, year: year} = state.parsed_date do
        assert day == int_or_nil(expected_day)
        assert month == int_or_nil(expected_month)
        assert year == int_or_nil(expected_year)
      end
      {:ok, state}
  end

  defp int_or_nil(:nil), do: :nil
  defp int_or_nil("nil"), do: :nil
  defp int_or_nil(string), do: String.to_integer(string)

  defp parse_date(date_string, default_year) do
    DataSanitiser.DateUtils.date_string_to_tuple(
      date_string,
      int_or_nil(default_year)
    )
  end
end
