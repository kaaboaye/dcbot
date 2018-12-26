defmodule Dcbot.Repo.Migrations.CreateDiscordUsers do
  use Ecto.Migration

  def change do
    create table(:discord_users, primary_key: false) do
      add :id, Dcbot.Discord.Types.Snowflake.type(), primary_key: true

      timestamps()
    end
  end
end
