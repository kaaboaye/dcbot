defmodule Dcbot.Ok do
  def process_message(msg) do
    nlp = Witai.get_nlp(msg)

    []
    |> weather(nlp)
    |> hi(nlp)
    |> love(nlp)
    |> see_you(nlp)
    |> swear(nlp)
    |> help(nlp)
  end

  defp weather(results, %{"location" => locations, "weather" => _}) do
    res =
      locations
      |> Enum.map(& &1["value"])
      |> Enum.map(fn place -> Task.async(fn -> Yahoo.get_weather_conditions(place) end) end)
      |> Enum.map(&Task.await/1)

    [{:weather_conditions, res} | results]
  end

  defp weather(results, _), do: results

  defp hi(results, %{"hi" => _}), do: [:hi | results]
  defp hi(results, _), do: results

  defp love(results, %{"love" => _}), do: [:love | results]
  defp love(results, _), do: results

  defp see_you(results, %{"see_you" => _}), do: [:see_you | results]
  defp see_you(results, _), do: results

  defp swear(results, %{"swear" => _}), do: [:swear | results]
  defp swear(results, _), do: results

  defp help(results, %{"help" => _}), do: [:help | results]
  defp help(results, _), do: results
end
