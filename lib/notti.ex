defmodule Notti do
  @moduledoc """
  Documentation for Notti.
  """
  require Logger

  def trigger(notification, opts \\ []) do
    notification
    # Which parties are interested in that notification
    |> Notti.Notification.receiving_parties(opts)
    # For each party build all the actions needed to happen
    # for the notification
    |> Enum.flat_map(fn party ->
      party
      |> Notti.ReceivingParty.notification_to_actions(notification, opts)
      |> Enum.map(fn {channel, details} ->
        {channel,
         Notti.Notification.build_for_channel(notification, channel, party, details, opts)}
      end)
    end)
    # Filter and warn for unimplemented notifications
    |> filter_unsupported()
    # Group by channel
    |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
    # Hand of to channels
    |> Enum.each(fn {channel, actions} ->
      channel.send_many(actions, opts)
    end)
  end

  defp filter_unsupported(actions) do
    Enum.filter(actions, fn
      {channel, {:not_supported, notification, party, details}} ->
        metadata = [
          channel: channel,
          notification: notification,
          party: party,
          details: details
        ]

        Logger.warn("Unimplemented notification", metadata)

        false

      {_, _} ->
        true
    end)
  end
end
