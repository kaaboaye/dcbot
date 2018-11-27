defmodule DcbotDiscord.MessageCreate do
  require Logger

  def process_message(msg) do
    with :noop <- DcbotDiscord.Ok.process_message(msg) do
      :noop
    else
      {:error, err} ->
        Logger.error("(discord) route returned error: #{inspect(err)} for msg: #{inspect(msg)}")
        :error

      :ok ->
        Logger.debug("(discord) handled message_create #{inspect(msg)}")
        :ok
    end
  end
end
