defmodule GCloudex.CloudSQL.Request do
  @moduledoc """
  Offers HTTP requests to be used in by the Google Cloud SQL wrapper.
  """
  alias HTTPoison, as: HTTP
  alias HTTPoison.HTTPResponse
  alias GCloudex.Auth, as: Auth

  defp project_id, do: GCloudex.project_id

  @doc """
  Sends a HTTP request with the given 'verb', 'headers' and 'body' to the
  specified 'endpoint'. The authorization and google project headers are
  added automatically.
  """
  @spec request(verb :: atom, endpoint :: binary, headers :: [{key :: binary, value :: binary}], body :: binary) :: HTTPResponse.t
  def request(verb, endpoint, headers \\ [], body \\ "") do
    HTTP.request(
      verb,
      endpoint,
      body,
      headers ++ [{"x-goog-project-id", project_id},
                  {"Authorization", "Bearer #{Auth.get_token_storage(:sql_admin)}"}],
      []
    )
  end

  @doc """
  Sends a HTTP request with the given 'verb', 'headers', 'body' and query
  'parameters' to the specified 'endpoint'. The authorization and google
  project headers are added automatically.
  """
  @spec request_query(verb :: atom, endpoint :: binary, headers :: [{key :: binary, value :: binary}], body :: binary, parameters :: binary) :: HTTPResponse.t
  def request_query(verb, endpoint, headers \\ [], body \\ "", parameters) do
    HTTP.request(
      verb,
      endpoint <> "/" <> parameters,
      body,
      headers ++ [{"x-goog-project-id", project_id},
                  {"Authorization", "Bearer #{Auth.get_token_storage(:sql_admin)}"}],
      []
    )
  end
end
