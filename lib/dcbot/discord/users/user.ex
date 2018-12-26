defmodule Dcbot.Discord.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Dcbot.Discord.Types.Snowflake, autogenerate: false}
  schema "discord_users" do
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:id])
    |> validate_required([:id])
  end
end
