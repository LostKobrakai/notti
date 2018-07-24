defmodule Database do
  def send_many(details) do
    details
    |> Enum.group_by(& &1.notification)
    |> Enum.map(fn {notification, details} ->
      send(self(), {__MODULE__, notification})

      Enum.map(details, fn detail ->
        send(self(), {__MODULE__, notification, detail})
      end)
    end)

    :ok
  end
end
