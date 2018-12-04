defmodule DcbotDiscord.Users.Presence do
  def handle(:online, user_id) do
    user_id
    |> Nostrum.Api.create_dm!()
    |> Map.get(:id)
    |> Nostrum.Api.create_message("siemka")
  end

  def handle(_status, _user_id), do: :noop
end
