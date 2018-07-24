defprotocol Notti.ReceivingParty do
  alias Notti.Notification
  @type t :: term

  @spec notification_to_actions(t, Notification.t()) :: list(term)
  def notification_to_actions(party, notification)
end
