defmodule GCloudex.ComputeEngine.Request do
  alias GCloudex.Auth, as: Auth
  require Logger
  import GCloudex, only: [project_id: 0]

  @spec request(verb :: atom, endpoint :: binary, headers :: [{binary, binary}], body :: binary, parameters :: binary) :: HTTPResponse.t
  def request(verb, endpoint, headers \\ [], body \\ "", parameters \\ "") do
    endpoint =
    if parameters == "" do
      endpoint
    else
      endpoint <> "/" <> "?" <> parameters
    end

    HTTPoison.request(
      verb,
      endpoint,
      body,
      headers ++ [{"x-goog-project-id", project_id},
                  {"Authorization", "Bearer #{Auth.get_token_storage(:compute)}"}],
      []
    )
  end
end
