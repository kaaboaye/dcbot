defmodule Dcbot.Discord.Guilds.Queries do
  import Ecto.Query

  alias Dcbot.Discord.Guilds.Member

  def get_guild_member(guild_id, user_id) do
    Member
    |> where([m], m.guild_id == ^guild_id)
    |> where([m], m.user_id == ^user_id)
  end
end
