defmodule Yahoo.Service do
  import Yahoo.Api

  def get_forecast(places) do
    places =
      places
      |> Enum.filter(&is_binary/1)
      |> Enum.map(&Jason.encode!/1)
      |> Enum.join(", ")

    yql = """
      SELECT *
      FROM weather.forecast
      WHERE
        woeid IN(
          SELECT woeid
          FROM geo.places(1)
          WHERE text IN(#{places})
        )
        AND u='c'
    """

    query =
      URI.encode_query(
        q: yql,
        format: "json",
        env: "store://datatables.org/alltableswithkeys"
      )

    get("/v1/public/yql?#{query}")
    |> case do
      {:ok, %{status_code: 200, body: body}} -> {:ok, body}
      _ -> :error
    end
  end
end
