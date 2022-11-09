defmodule API.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :api,
  module: API.Guardian,
  error_handler: API.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
