defmodule Yahoo.Api do
  use HTTPoison.Base

  def process_url(url) do
    "https://query.yahooapis.com" <> url
  end

  def process_request_body(body) when is_map(body) do
    Jason.encode!(body)
  end

  def process_request_body(body), do: body

  def process_response_body(binary) do
    Jason.decode!(binary)
  end
end
