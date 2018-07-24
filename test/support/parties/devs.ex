defimpl Notti.ReceivingParty, for: Atom do
  def notification_to_actions(:devs, _notification) do
    [
      {Slack, %{channel: "#devs", icon: "butler"}}
    ]
  end
end
