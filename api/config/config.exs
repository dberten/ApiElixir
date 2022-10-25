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

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
