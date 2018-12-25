defmodule Dcbot.Repo.Migrations.CreateDiscordGuildMembers do
  use Ecto.Migration

  def change do
    create table(:discord_guild_members, primary_key: false) do
      add :guild_id,
          references(:discord_guilds,
            on_delete: :nothing,
            type: Dcbot.Discord.Types.Snowflake.type()
          ),
          primary_key: true

      add :user_id,
          references(:discord_users,
            on_delete: :nothing,
            type: Dcbot.Discord.Types.Snowflake.type()
          ),
          primary_key: true

      add :eula_asked_id,
          references(
            :discord_guild_eulas,
            on_delete: :nothing,
            type: :uuid
          )

      add :eula_accepted_id,
          references(
            :discord_guild_eulas,
            on_delete: :nothing,
            type: :uuid
          )

      timestamps()
    end
  end
end
