defmodule Dcbot.Repo.Migrations.CreateDiscordUsers do
  use Ecto.Migration

  def change do
    create table(:discord_users, primary_key: false) do
      add :id, Dcbot.Discord.Types.Snowflake.type(), primary_key: true
      add :username, :string, null: false
      add :email, :string
      add :avatar, :string
      add :bot, :boolean
      add :discriminator, :string, size: 4, null: false
      add :mfa_enabled, :boolean
      add :verified, :boolean

      timestamps()
    end

    create index(:discord_users, [:username])
    create index(:discord_users, [:email])
  end
end
