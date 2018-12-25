defmodule Dcbot.Discord.Guilds.Member do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dcbot.Discord.Types.Snowflake

  @primary_key false
  schema "discord_guild_members" do
    field :guild_id, Snowflake
    field :user_id, Snowflake
    field :eula_accepted, :string
    field :eula_asked, :string

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [:eula_asked, :eula_accepted])
    |> validate_required([:eula_asked, :eula_accepted])
  end
end
