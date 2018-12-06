defprotocol Notti.ReceivingParty do
  alias Notti.Notification
  @type t :: term

  @spec notification_to_actions(t, Notification.t(), Keyword.t() | map) :: list(term)
  def notification_to_actions(party, notification, opts)
end
