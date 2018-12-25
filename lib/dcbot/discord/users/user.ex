defmodule Dcbot.Discord.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Dcbot.Discord.Types.Snowflake, autogenerate: false}
  schema "discord_users" do
    field :username, :string
    field :email, :string
    field :avatar, :string
    field :bot, :boolean
    field :discriminator, :string
    field :mfa_enabled, :boolean
    field :verified, :boolean

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :id,
      :username,
      :email,
      :avatar,
      :bot,
      :discriminator,
      :mfa_enabled,
      :verified
    ])
    |> validate_required([
      :id,
      :username,
      :discriminator
    ])
  end
end
