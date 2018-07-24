defmodule Email do
  def send_many(details) do
    Enum.map(details, fn detail ->
      send(self(), {__MODULE__, detail})
    end)

    :ok
  end
end
