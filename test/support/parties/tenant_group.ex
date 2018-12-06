defmodule TenantGroup do
  defstruct [:tenant, :role]

  defimpl Notti.ReceivingParty do
    def notification_to_actions(%{tenant: 1, role: :trainer}, _notification, _opts) do
      [
        {Email, %{first_name: "Karl", email: "trainer_karl@example.com"}},
        {Email, %{first_name: "Sophie", email: "trainer_sophie@example.com"}},
        {Email, %{first_name: "Maria", email: "trainer_maria@example.com"}},
        {Database, %{uuid: "karl"}},
        {Database, %{uuid: "sophie"}},
        {Database, %{uuid: "maria"}}
      ]
    end

    def notification_to_actions(%{tenant: 1, role: :manager}, _notification, _opts) do
      [
        {Email, %{first_name: "Walter", email: "manager_walter@example.com"}},
        {Email, %{first_name: "Hans", email: "manager_hans@example.com"}}
      ]
    end
  end
end
