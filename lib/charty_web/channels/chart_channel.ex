defmodule ChartyWeb.ChartChannel do
  use ChartyWeb, :channel

  def join("chart:example", _payload, socket) do
    {:ok, socket}
  end
end
