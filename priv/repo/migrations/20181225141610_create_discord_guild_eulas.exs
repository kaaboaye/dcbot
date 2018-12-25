defmodule Dcbot.Repo.Migrations.CreateDiscordGuildEulas do
  use Ecto.Migration

  def change do
    create table(:discord_guild_eulas, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :eula, :text, null: false

      add :guild_id,
          references(:discord_guilds,
            on_delete: :nothing,
            type: Dcbot.Discord.Types.Snowflake.type()
          ),
          null: false

      timestamps()
    end

    alter table(:discord_guilds) do
      add :eula_id, references(:discord_guild_eulas, on_delete: :nothing, type: :uuid)
    end
  end
end
