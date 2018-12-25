defmodule Dcbot.Discord.Guilds.Guild do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dcbot.Discord.Guilds.{Member, Eula}

  @primary_key {:id, Dcbot.Discord.Types.Snowflake, autogenerate: false}
  schema "discord_guilds" do
    has_many :members, Member
    has_many :eulas, Eula

    @foreign_key_type :binary_id
    belongs_to :eula, Eula

    timestamps()
  end

  @doc false
  def changeset(guild, attrs) do
    guild
    |> cast(attrs, [:id, :eula_id])
    |> validate_required([:id])
  end
end
