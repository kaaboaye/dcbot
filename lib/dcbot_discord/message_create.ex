defmodule DcbotDiscord.MessageCreate do
  require Logger

  def process_message(msg) do
    with :noop <- DcbotDiscord.Ping.processs_message(msg) do
      :noop
    else
      {:error, _} = err ->
        err

      :ok ->
        Logger.debug("(discord) handled message_create #{inspect(msg)}")
        :ok
    end
  end
end
