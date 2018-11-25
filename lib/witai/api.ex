defmodule Witai.Api do
  use HTTPoison.Base

  @token Application.get_env(:dcbot, Witai, []) |> Keyword.get(:token, {})

  def process_url(url) do
    "https://api.wit.ai" <> url
  end

  def process_request_headers(headers) do
    headers ++
      [
        Authorization: "Bearer #{@token}"
      ]
  end

  def process_request_body(body) when is_map(body) do
    Jason.encode!(body)
  end

  def process_request_body(body), do: body

  def process_response_body(binary) do
    Jason.decode!(binary)
  end
end
