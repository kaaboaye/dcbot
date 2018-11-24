defmodule DcbotDiscord.Ping do
  import Nostrum.Api

  def processs_message(%{content: "!ping", channel_id: channel_id}) do
    create_message(channel_id, "Pong!")
    :ok
  end

  def processs_message(%{content: "!hi", channel_id: channel_id, author: %{username: username}}) do
    create_message(channel_id, "Hi, #{username}!")
    :ok
  end

  def processs_message(%{content: "!say " <> msg, channel_id: channel_id}) do
    create_message(channel_id, "Mówię #{msg}")
    :ok
  end

  def processs_message(%{content: "!help", channel_id: channel_id}) do
    msg = """
    Lista komend:
    \t!help - Ta właśnie wiadomość
    \t!hi - Bot się przywita <3
    \t!say :msg - Bot powie :msg
    \t!ping - Pong
    """

    create_message(channel_id, msg)
    :ok
  end

  def processs_message(_), do: :noop
end
