defmodule Dcbot.Discord.Users do
  alias Nostrum.Api

  alias Dcbot.Repo
  alias Dcbot.Discord.Users.User
  alias Dcbot.Discord.Guilds

  def fetch_all_active_users(guilds) do
    guilds
    |> Enum.map(fn %{id: id} ->
      Task.async(fn ->
        Api.list_guild_members!(id)
        |> Enum.map(&{id, &1})
      end)
    end)
    |> Enum.map(&Task.await/1)
    |> List.flatten()
    |> Enum.map(&register_user_if_new/1)
  end

  def register_user_if_new({guild_id, %Nostrum.Struct.Guild.Member{user: user}}) do
    %{id: user_id} = register_user_if_new(user)
    Guilds.create_guild_member(guild_id, user_id)

    user
  end

  def register_user_if_new(%Nostrum.Struct.User{} = user) do
    with nil <- Repo.get(User, user.id) do
      dc_user = Map.from_struct(user)

      %User{}
      |> User.changeset(dc_user)
      |> Repo.insert!()
    end
  end

  def register_user_if_new(user_id) when is_number(user_id) do
    with nil <- Repo.get(User, user_id) do
      dc_user =
        user_id
        |> Api.get_user!()
        |> Map.from_struct()

      %User{}
      |> User.changeset(dc_user)
      |> Repo.insert!()
    end
  end

  # @current_eula "siemka"

  # def ask_eula(%User{id: id, eula_asked: eula_asked, eula_accepted: eula_accepted} = user)
  #     when eula_asked != @current_eula and eula_accepted != @current_eula do
  #   id
  #   |> Nostrum.Api.create_dm!()
  #   |> Map.get(:id)
  #   |> Nostrum.Api.create_message("siemka")

  #   user
  #   |> User.changeset(%{eula_asked: @current_eula})
  #   |> Repo.update!()
  # end

  # def ask_eula(%User{} = user), do: user
end
