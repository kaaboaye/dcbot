defmodule Dcbot.Ok do
  def process_message(msg) do
    msg
    |> Witai.get_nlp()
    |> process_nlp_results()
  end

  defp process_nlp_results(%{"location" => locations, "weather" => _}) do
    res =
      locations
      |> Enum.map(& &1["value"])
      |> Enum.map(fn place -> Task.async(fn -> Yahoo.get_weather_conditions(place) end) end)
      |> Enum.map(&Task.await/1)

    {:weather_conditions, res}
  end

  defp process_nlp_results(_), do: :noop
end
