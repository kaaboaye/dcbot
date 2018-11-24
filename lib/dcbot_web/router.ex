defmodule DcbotWeb.Router do
  use DcbotWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DcbotWeb do
    pipe_through :api
  end
end
