# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :api,
  namespace: API,
  ecto_repos: [API.Repo]

# Configures the endpoint
config :api, APIWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "p4rWQawJEtozRkqYhkCKQkYKGLNgYw0yRjyxUBHiLAFdLAMG/jUtLN8tD/XsQ6vb",
  render_errors: [view: APIWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: API.PubSub,
  live_view: [signing_salt: "Fy15XYbL"]

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :api, API.Guardian,
  issuer: "API",
  secret_key: "Mp+V7lhiIjb2eUV9J9wkf0/Kz5xustGEQoiSF+0NeKegetbOuGEY4SlbzpeTgWAm"
# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
