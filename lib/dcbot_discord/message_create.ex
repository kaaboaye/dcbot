defmodule DcbotDiscord.MessageCreate do
  require Logger

  alias Nostrum.Api

  @nlp_keyword ~r/^[oO][kK] /

  def process_message(msg) do
    process_nlp_message(msg)
  end

  def process_nlp_message(%{content: content} = msg) do
    with true <- Regex.match?(@nlp_keyword, content),
         new_content <- Regex.replace(@nlp_keyword, content, "") do
      msg = Map.put(msg, :content, new_content)
      nlp = nlp = Witai.get_nlp(new_content)

      DcbotDiscord.Ok.Router.handlers()
      |> Enum.map(fn
        {module, module_handlers} ->
          Enum.map(module_handlers, fn handler ->
            Task.async(fn -> apply(module, handler, [msg, nlp]) end)
          end)
      end)
      |> List.flatten()
      |> Enum.map(&Task.await/1)
      |> Enum.count(&(&1 == :ok))
      |> case do
        0 -> Api.create_message(msg.channel_id, "Nie rozumiem :(")
        _ -> :ok
      end
    end
  end
end
