defmodule Dcbot.Discord.Guilds.Member do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dcbot.Discord.Types.Snowflake
  alias Dcbot.Discord.Guilds.{Guild, Eula}
  alias Dcbot.Discord.Users.User

  @primary_key false
  schema "discord_guild_members" do
    @foreign_key_type Snowflake
    belongs_to :guild, Guild, primary_key: true
    belongs_to :user, User, primary_key: true

    @foreign_key_type :binary_id
    belongs_to :eula_accepted, Eula
    belongs_to :eula_asked, Eula

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [:eula_asked_id, :eula_accepted_id])
  end
end
