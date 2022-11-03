defmodule TodolistWeb.Router do
  use TodolistWeb, :router

  pipeline :browser do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :put_root_layout, {TodolistWeb.LayoutView, :root}
    plug :put_secure_browser_headers
    plug CORSPlug, origin: "*"
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  scope "/api", TodolistWeb do
    pipe_through :api
    resources "/users", UsersController, except: [:new, :edit]
    resources "/workingtimes", WorkingtimeController, except: [:new, :edit]
    post "/workingtimes/:userid", WorkingtimeController, :createOne
    get "/workingtimes/:userid/:id", WorkingtimeController, :getByParams
    resources "/clock", ClockController, except: [:new, :edit]
    post "/clock/:userid", ClockController, :createOneClock

  end


  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TodolistWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
