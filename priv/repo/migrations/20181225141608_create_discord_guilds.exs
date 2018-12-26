defmodule Dcbot.Repo.Migrations.CreateDiscordGuilds do
  use Ecto.Migration

  def change do
    create table(:discord_guilds, primary_key: false) do
      add :id, Dcbot.Discord.Types.Snowflake.type(), primary_key: true

      timestamps()
    end
  end
end
