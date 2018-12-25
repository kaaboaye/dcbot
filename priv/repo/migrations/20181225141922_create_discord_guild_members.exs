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

      add :eula_asked, :string, default: "none", null: false
      add :eula_accepted, :string, default: "none", null: false

      timestamps()
    end
  end
end
