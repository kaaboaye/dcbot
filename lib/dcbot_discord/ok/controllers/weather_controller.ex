defmodule DcbotDiscord.Ok.WeatherController do
  import DcbotDiscord.Ok.WeatherViews

  def weather(msg, nlp) do
    with %{"location" => locations, "weather" => _} <- nlp do
      locations =
        locations
        |> Enum.map(& &1["value"])
        |> Enum.map(fn place -> Task.async(fn -> Yahoo.get_weather_conditions(place) end) end)
        |> Enum.map(&Task.await/1)

      render_weather(msg, locations)
      :ok
    end
  end
end
