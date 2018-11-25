defmodule Yahoo do
  import Yahoo.Service

  def get_weather_conditions(place) do
    {:ok, forecast} = get_forecast(place)

    channel = get_in(forecast, ["query", "results", "channel"])
    city = get_in(channel, ["location", "city"])
    condition = get_in(channel, ["item", "condition"])

    %{
      raw_place: place,
      city: city,
      temp: "#{condition["temp"]}ºC",
      text: condition["text"]
    }
  end
end
