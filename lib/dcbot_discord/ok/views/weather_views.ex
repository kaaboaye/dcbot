defmodule DcbotDiscord.Ok.WeatherViews do
  import Nostrum.Api

  def render_weather(%{channel_id: channel_id}, locations) do
    cities =
      locations
      |> Enum.map(fn location ->
        if is_binary(location.city) do
          ":sunny: W mieście #{location.city} jest #{location.temp} #{location.text}."
        else
          "Nie słyszałem o mieście zwanym `#{location.raw_place}` :("
        end
      end)
      |> Enum.join("\n")

    create_message(channel_id, "#{cities}\nPowerd by Wit.Ai :rainbow: Yahoo")
  end
end
