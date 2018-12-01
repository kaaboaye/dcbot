defmodule DcbotDiscord.Ok.Router do
  def module(module) do
    functions =
      module.__info__(:functions)
      |> Enum.filter(fn
        {_, 2} -> true
        _ -> false
      end)
      |> Enum.map(fn {fun, _} -> fun end)

    {module, functions}
  end

  def handlers do
    [
      module(DcbotDiscord.Ok.BasicController),
      module(DcbotDiscord.Ok.WeatherController)
    ]
  end
end
