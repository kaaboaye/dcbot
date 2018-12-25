defmodule Dcbot.Discord.Guilds.Guild do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dcbot.Discord.Guilds.Member

  @primary_key {:id, Dcbot.Discord.Types.Snowflake, autogenerate: false}
  schema "discord_guilds" do
    has_many(:members, Member)

    timestamps()
  end

  @doc false
  def changeset(guild, attrs) do
    guild
    |> cast(attrs, [:id])
    |> validate_required([:id])
  end
end
