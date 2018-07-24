defmodule InvitationAccepted do
  defstruct [:invitation]

  defimpl Notti.Notification do
    @doc """
    The parties interested in invitations are:

    * manager -> managers, devs
    * trainer -> managers, trainers, devs

    """
    def receiving_parties(%{invitation: %{tenant: tenant, type: :manager}}) do
      [
        %TenantGroup{tenant: tenant, role: :manager},
        :devs
      ]
    end

    def receiving_parties(%{invitation: %{tenant: tenant, type: :trainer}}) do
      [
        %TenantGroup{tenant: tenant, role: :manager},
        %TenantGroup{tenant: tenant, role: :trainer},
        :devs
      ]
    end

    @doc """
    There are 3 versions of notifications:

    * Email for Managers
    * Email for Trainers
    * Slack message for Devs
    * Database for Trainers

    """
    # Email for Managers
    def build_for_channel(notification, Email, %TenantGroup{role: :manager}, details) do
      %{
        to: "#{details.first_name} <#{details.email}>",
        subject: "Invited #{notification.invitation.type} joined",
        body:
          "Invited #{notification.invitation.type} joined the tenant" <>
            " managed by you: #{notification.invitation.tenant}"
      }
    end

    # Email for Trainers
    def build_for_channel(notification, Email, %TenantGroup{role: :trainer}, details) do
      %{
        to: "#{details.first_name} <#{details.email}>",
        subject: "Trainer joined",
        body: "New mate in: #{notification.invitation.tenant}"
      }
    end

    # Slack message for Devs
    def build_for_channel(notification, Slack, :devs, details) do
      Map.merge(details, %{
        body:
          "New #{notification.invitation.type} joined on" <>
            " invitation for: #{notification.invitation.tenant}"
      })
    end

    # Database for Trainers
    def build_for_channel(notification, Database, %TenantGroup{role: :trainer}, details) do
      Map.merge(details, %{
        notification: %{
          body: "New mate in: #{notification.invitation.tenant}"
        }
      })
    end

    # Fail
    def build_for_channel(notification, _, party, details) do
      {:not_supported, notification, party, details}
    end
  end
end
