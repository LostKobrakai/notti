defmodule Notti.Channel do
  @type t :: module

  @callback send_many(list(map)) :: list(:ok | {:error, term})
end
