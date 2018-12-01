defmodule DcbotDiscord.Ok.BasicController do
  import DcbotDiscord.Ok.BasicViews

  def hi(msg, nlp) do
    with %{"hi" => _} <- nlp do
      render_hi(msg)
      :ok
    end
  end

  def love(msg, nlp) do
    with %{"love" => _} <- nlp do
      render_love(msg)
      :ok
    end
  end

  def see_you(msg, nlp) do
    with %{"see_you" => _} <- nlp do
      render_see_you(msg)
      :ok
    end
  end

  def swear(msg, nlp) do
    with %{"swear" => _} <- nlp do
      render_swear(msg)
      :ok
    end
  end

  def help(msg, nlp) do
    with %{"help" => _} <- nlp do
      render_help(msg)
      :ok
    end
  end

  def sad(msg, nlp) do
    with %{"sad" => _} <- nlp do
      render_sad(msg)
      :ok
    end
  end

  def thebita(msg, nlp) do
    with %{"thebita" => _} <- nlp do
      render_thebita(msg)
      :ok
    end
  end

  def ok(msg, nlp) do
    if msg.content == "" or Map.get(nlp, "ok") != nil do
      render_ok(msg)
      :ok
    end
  end
end
