defmodule Yahoo.Service do
  import Yahoo.Api

  def get_forecast(place) do
    query =
      URI.encode_query(
        q:
          "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"#{
            place
          }\") and u='c'",
        format: "json",
        env: "store://datatables.org/alltableswithkeys"
      )

    get("/v1/public/yql?#{query}")
    |> case do
      {:ok, %{status_code: 200, body: body}} -> {:ok, body}
    end
  end
end
