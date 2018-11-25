defmodule Witai do
  import Witai.Service

  def get_nlp(msg) do
    with {:ok, %{"entities" => entities}} <- get_message(msg) do
      entities
      |> Enum.filter(fn {_, words} ->
        len =
          Enum.filter(words, &(&1["confidence"] > 0.5))
          |> length()

        len > 0
      end)
    end
    |> Map.new()
  end
end
