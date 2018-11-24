defmodule DcbotDiscord do
  use Nostrum.Consumer

  import DcbotDiscord.MessageCreate

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}) do
    process_message(msg)
  end

  def handle_event(_event) do
    :noop
  end
end
