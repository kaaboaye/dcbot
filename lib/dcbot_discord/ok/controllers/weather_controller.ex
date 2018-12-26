defmodule DcbotDiscord.Ok.WeatherController do
  import DcbotDiscord.Ok.WeatherViews

  def weather(msg, nlp) do
    with %{"location" => locations, "weather" => _} <- nlp do
      locations =
        locations
        |> Enum.map(& &1["value"])
        |> Yahoo.get_weather_conditions()

      render_weather(msg, locations)
      :ok
    end
  end
end
