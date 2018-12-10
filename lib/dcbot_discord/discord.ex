defmodule DcbotDiscord do
  use Nostrum.Consumer

  alias DcbotDiscord.{Users, MessageCreate}

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}) do
    MessageCreate.process_message(msg)
  end

  def handle_event({:PRESENCE_UPDATE, {_, _, %{status: status, user: %{id: user_id}}}, _}) do
    Users.Presence.handle(status, user_id)
  end

  def handle_event(_event) do
    :noop
  end
end
