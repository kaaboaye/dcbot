defmodule DcbotDiscord.Ok do
  alias Dcbot.Ok
  alias DcbotDiscord.Ok.Views

  def process_message(%{content: "ok " <> cmd, channel_id: channel_id}) do
    cmd
    |> Ok.process_message()
    |> Views.render(channel_id)

    :ok
  end

  def process_message(_), do: :noop
end
