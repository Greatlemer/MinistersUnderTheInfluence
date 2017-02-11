defmodule WhiteBreadConfig do
  use WhiteBread.SuiteConfiguration

  suite name:          "Data Layouts",
        context:       DataLayoutsContext,
        feature_paths: ["features/data_layouts.feature"]

  suite name:          "Date Formats",
        context:       DateFormatsContext,
        feature_paths: ["features/date_formats.feature"]
end
