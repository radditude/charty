defmodule ChartyWeb.PageController do
  use ChartyWeb, :controller

  alias Charty.Examples

  def index(conn, _params) do
    example_data = Examples.list_examples_by_type()

    example_counts =
      example_data
      |> Map.values()
      |> Jason.encode!()

    examples =
      example_data
      |> Map.keys()
      |> Jason.encode!()

    render(conn, "index.html", examples: examples, example_counts: example_counts)
  end
end
