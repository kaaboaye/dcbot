defmodule Witai.Service do
  import Witai.Api

  def get_message(msg) do
    query =
      URI.encode_query(
        v: "20181125",
        q: msg
      )

    get("/message?#{query}")
    |> case do
      {:ok, %{status_code: 200, body: body}} -> {:ok, body}
      _ -> {:error, :error}
    end
  end
end
