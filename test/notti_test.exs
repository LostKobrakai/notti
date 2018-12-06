defmodule NottiTest do
  use ExUnit.Case

  describe "trigger/1" do
    test "returns :ok for correct usage" do
      notification = %InvitationAccepted{invitation: %{tenant: 1, type: :manager}}

      assert Notti.trigger(notification, []) == :ok

      assert_received {Email,
                       %{
                         body: "Invited manager joined the tenant managed by you: 1",
                         subject: "Invited manager joined",
                         to: "Walter <manager_walter@example.com>"
                       }}

      assert_received {Email,
                       %{
                         body: "Invited manager joined the tenant managed by you: 1",
                         subject: "Invited manager joined",
                         to: "Hans <manager_hans@example.com>"
                       }}

      assert_received {Slack,
                       %{
                         body: "New manager joined on invitation for: 1",
                         channel: "#devs",
                         icon: "butler"
                       }}
    end

    test "trainer" do
      notification = %InvitationAccepted{invitation: %{tenant: 1, type: :trainer}}

      assert Notti.trigger(notification, []) == :ok

      assert_received {Email,
                       %{
                         body: "New mate in: 1",
                         subject: "Trainer joined",
                         to: "Karl <trainer_karl@example.com>"
                       }}

      assert_received {Email,
                       %{
                         body: "New mate in: 1",
                         subject: "Trainer joined",
                         to: "Sophie <trainer_sophie@example.com>"
                       }}

      assert_received {Email,
                       %{
                         body: "New mate in: 1",
                         subject: "Trainer joined",
                         to: "Maria <trainer_maria@example.com>"
                       }}

      assert_received {Email,
                       %{
                         body: "Invited trainer joined the tenant managed by you: 1",
                         subject: "Invited trainer joined",
                         to: "Walter <manager_walter@example.com>"
                       }}

      assert_received {Email,
                       %{
                         body: "Invited trainer joined the tenant managed by you: 1",
                         subject: "Invited trainer joined",
                         to: "Hans <manager_hans@example.com>"
                       }}

      assert_received {Slack,
                       %{
                         body: "New trainer joined on invitation for: 1",
                         channel: "#devs",
                         icon: "butler"
                       }}

      assert_received {Database,
                       %{
                         body: "New mate in: 1"
                       }}

      assert_received {Database,
                       %{
                         body: "New mate in: 1"
                       },
                       %{
                         uuid: "karl"
                       }}

      assert_received {Database,
                       %{
                         body: "New mate in: 1"
                       },
                       %{
                         uuid: "sophie"
                       }}

      assert_received {Database,
                       %{
                         body: "New mate in: 1"
                       },
                       %{
                         uuid: "maria"
                       }}
    end

    test "fails for something not implementing Notti.Notification" do
      assert_raise Protocol.UndefinedError, fn ->
        Notti.trigger(false, [])
      end
    end
  end
end
