defmodule DcbotDiscord.Ok.BasicViews do
  import Nostrum.Api

  def render_hi(%{channel_id: channel_id}) do
    create_message(channel_id, "Siemka :rainbow::kissing_heart::rainbow:")
  end

  def render_love(%{channel_id: channel_id}) do
    create_message(channel_id, "Ja ciebie też :heart::heart::heart:")
  end

  def render_see_you(%{channel_id: channel_id}) do
    create_message(channel_id, "Do zobaczenia :kissing_heart:")
  end

  def render_swear(%{channel_id: channel_id}) do
    create_message(channel_id, "Nie przeklinaj :cold_sweat::scream::cold_sweat:")
  end

  def render_help(%{channel_id: channel_id}) do
    create_message(channel_id, "Możesz się mnie zapytać o pogodę")
  end

  def render_sad(%{channel_id: channel_id}) do
    create_message(channel_id, ":cold_sweat::cold_sweat::cold_sweat:")
  end

  def render_thebita(%{channel_id: channel_id}) do
    create_message(channel_id, "**pstryk**")
    create_message(channel_id, "Fuuuuuuuu")
  end

  def render_ok(%{channel_id: channel_id}) do
    create_message(channel_id, "OK.")
  end
end
