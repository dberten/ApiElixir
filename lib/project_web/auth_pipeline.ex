defmodule Project.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :project,
  module: Project.Guardian,
  error_handler: Project.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
