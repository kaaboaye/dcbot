defmodule Yahoo do
  import Yahoo.Service

  def get_weather_conditions(places) do
    with {:ok, forecasts} <- get_forecast(places) do
      get_in(forecasts, ["query", "results", "channel"])
      |> Enum.map(fn channel ->
        city = get_in(channel, ["location", "city"])
        condition = get_in(channel, ["item", "condition"])

        %{
          raw_place: :place,
          city: city,
          temp: "#{condition["temp"]}ºC",
          text: condition["text"]
        }
      end)
    else
      _ -> []
    end
  end
end
