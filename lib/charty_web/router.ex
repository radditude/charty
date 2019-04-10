defmodule ChartyWeb.Router do
  use ChartyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChartyWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/examples", ExampleController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChartyWeb do
  #   pipe_through :api
  # end
end
