defmodule Dcbot.Discord.Guilds.Eula do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dcbot.Discord.Types.Snowflake
  alias Dcbot.Discord.Guilds.Guild

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "discord_guild_eulas" do
    field :eula, :string
    field :name, :string

    @foreign_key_type Snowflake
    belongs_to :guild, Guild

    timestamps()
  end

  @doc false
  def changeset(eula, attrs) do
    eula
    |> cast(attrs, [:name, :eula, :guild_id])
    |> validate_required([:name, :eula])
  end

  def to_string(%Dcbot.Discord.Guilds.Eula{} = eula) do
    """
    **#{eula.name}**

    #{eula.eula}

    _EULA id: #{eula.id}_
    """
  end
end
