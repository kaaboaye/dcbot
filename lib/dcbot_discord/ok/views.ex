defmodule DcbotDiscord.Ok.Views do
  import Nostrum.Api

  def render(list, channel_id) when is_list(list) do
    list
    |> Enum.map(fn view -> render(view, channel_id) end)
    |> case do
      [] -> render(:noop, channel_id)
      _ -> nil
    end
  end

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

  def render(:hi, channel_id) do
    create_message(channel_id, "Siemka :rainbow::kissing_heart::rainbow:")
    :ok
  end

  def render(:love, channel_id) do
    create_message(channel_id, "Ja ciebie też :heart::heart::heart:")
    :ok
  end

  def render(:see_you, channel_id) do
    create_message(channel_id, "Do zobaczenia :kissing_heart:")
    :ok
  end

  def render(:swear, channel_id) do
    create_message(channel_id, "Nie przeklinaj :cold_sweat::scream::cold_sweat:")
    :ok
  end

  def render(:help, channel_id) do
    create_message(channel_id, "Możesz się mnie zapytać o pogodę")
    :ok
  end

  def render(:noop, channel_id) do
    create_message(channel_id, "Nie rozumiem :(")
    :ok
  end
end
