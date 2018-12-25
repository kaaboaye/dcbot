defmodule DcbotDiscord do
  use Nostrum.Consumer

  alias DcbotDiscord.{MessageCreate}

  def init do
    Dcbot.Discord.Guilds.fetch_all_active_guilds()
    |> Dcbot.Discord.Users.fetch_all_active_users()
  end

  def start_link do
    Task.start(&init/0)
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}) do
    MessageCreate.process_message(msg)
  end

  def handle_event({:PRESENCE_UPDATE, {_, _, %{guild_id: guild_id, user: %{id: user_id}}}, _}) do
    Dcbot.Discord.Guilds.register_guild_member_if_new(guild_id, user_id)
  end

  def handle_event(_event) do
    :noop
  end
end
