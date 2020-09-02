defprotocol Notti.Notification do
  alias Notti.{Channel, ReceivingParty}

  @type t :: term

  @spec receiving_parties(t, Keyword.t() | map) :: list(ReceivingParty.t())
  def receiving_parties(notificiation, opts)

  @spec build_for_channel(t, ReceivingParty.t(), Channel.t(), map, Keyword.t() | map) :: term
  def build_for_channel(notification, channel, party, details, opts)
end
