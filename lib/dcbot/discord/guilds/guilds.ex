defmodule Dcbot.Discord.Guilds do
  import Ecto.Query

  alias Nostrum.Api

  alias Dcbot.Repo
  alias Dcbot.Discord.Guilds.{Guild, Member}
  alias Dcbot.Discord.Users

  def fetch_all_active_guilds do
    guilds = Api.get_current_user_guilds!()

    Enum.each(guilds, &register_guild_if_new/1)

    guilds
  end

  def register_guild_if_new(%Nostrum.Struct.Guild{} = guild) do
    with nil <- Repo.get(Guild, guild.id) do
      attrs =
        guild
        |> Map.from_struct()

      %Guild{}
      |> Guild.changeset(attrs)
      |> Repo.insert!()
    end
  end

  def register_guild_if_new(guild_id) when is_integer(guild_id) do
    with nil <- Repo.get(Guild, guild_id) do
      attrs =
        guild_id
        |> Api.get_guild!()
        |> Map.from_struct()

      %Guild{}
      |> Guild.changeset(attrs)
      |> Repo.insert!()
    end
  end

  def get_guild_member(guild_id, user_id) do
    Member
    |> where([m], m.guild_id == ^guild_id)
    |> where([m], m.user_id == ^user_id)
    |> Repo.one()
  end

  def create_guild_member(guild_id, user_id) do
    with nil <- get_guild_member(guild_id, user_id) do
      %Member{
        guild_id: guild_id,
        user_id: user_id
      }
      |> Repo.insert!()
    end
  end

  def register_guild_member_if_new(guild_id, user_id) do
    Users.register_user_if_new(user_id)
    register_guild_if_new(guild_id)
    create_guild_member(guild_id, user_id)
  end
end
