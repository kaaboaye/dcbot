defmodule DcbotDiscord.Ok.Views do
  import Nostrum.Api

  def render({:weather_conditions, locations}, channel_id) do
    Enum.map(
      locations,
      fn loc ->
        Task.async(fn ->
          msg =
            if is_binary(loc.city) do
              ":sunny: W mieście #{loc.city} jest #{loc.temp} #{loc.text}."
            else
              "Nie słyszałem o mieście zwanym `#{loc.raw_place}` :("
            end

          create_message(channel_id, msg)
        end)
      end
    )
    |> Enum.each(&Task.await/1)

    create_message(channel_id, "Powerd by Wit.Ai :rainbow: Yahoo")

    :ok
  end

  def render(:noop, channel_id) do
    create_message(channel_id, "Nie rozumiem :(")
    :noop
  end
end
