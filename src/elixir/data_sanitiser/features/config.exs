defmodule WhiteBreadConfig do
  use WhiteBread.SuiteConfiguration

  suite name:          "DataLayouts",
        context:       DataLayoutsContext,
        feature_paths: ["features/"]
end
