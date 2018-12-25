defmodule Dcbot.Discord.Guilds do
  import Ecto.Query

  alias Nostrum.Api

  alias Dcbot.Repo
  alias Dcbot.Discord.Guilds.{Queries, Guild, Member, Eula}
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

  def add_guild_eula(guild_id, attrs) do
    attrs = Map.put(attrs, :guild_id, guild_id)

    %Eula{}
    |> Eula.changeset(attrs)
    |> Repo.insert()
  end

  def set_default_guild_eula(guild_id, eula_id) do
    with %{guild_id: ^guild_id} <- get_eula(eula_id) do
      guild_id
      |> get_guild()
      |> Guild.changeset(%{eula_id: eula_id})
      |> Repo.update()
    else
      _ -> {:error, :not_found}
    end
  end

  def get_guild_member(guild_id, user_id) do
    Queries.get_guild_member(guild_id, user_id)
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
    |> ask_eula()
  end

  def get_guild(guild_id) do
    Repo.get(Guild, guild_id)
  end

  def get_eula(eula_id) do
    Repo.get(Eula, eula_id)
  end

  @spec register_guild_member_if_new(
          integer() | Nostrum.Struct.Guild.t(),
          number() | {any(), Nostrum.Struct.Guild.Member.t()} | Nostrum.Struct.User.t()
        ) :: any()
  def register_guild_member_if_new(guild_id, user_id) do
    Users.register_user_if_new(user_id)
    register_guild_if_new(guild_id)
    create_guild_member(guild_id, user_id)
  end

  def ask_eula(%Member{guild_id: guild_id, user_id: user_id}) do
    member? =
      Queries.get_guild_member(guild_id, user_id)
      |> preload([:user, :guild, guild: :eula])
      |> Repo.one()

    with %{} = member <- member?,
         true <- not is_nil(member.guild.eula_id) and member.eula_asked_id != member.guild.eula_id do
      member.user_id
      |> Api.create_dm!()
      |> Map.get(:id)
      |> Api.create_message!(Eula.to_string(member.guild.eula))

      member
      |> Member.changeset(%{eula_asked_id: member.guild.eula_id})
      |> Repo.update!()
    end
  end
end
