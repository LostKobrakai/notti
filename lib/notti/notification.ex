defprotocol Notti.Notification do
  alias Notti.{Channel, ReceivingParty}

  @type t :: term

  @spec receiving_parties(t) :: list(ReceivingParty.t())
  def receiving_parties(notificiation)

  @spec build_for_channel(t, ReceivingParty.t(), Channel.t(), map) :: list()
  def build_for_channel(notification, channel, party, details)
end
