defmodule Notti.Channel do
  @type t :: module

  @callback send_many(list(map), Keyword.t() | map) :: list(:ok | {:error, term})
end
