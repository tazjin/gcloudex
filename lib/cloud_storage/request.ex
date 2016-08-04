defmodule GCloudex.CloudStorage.Request do
  @moduledoc """
  Offers HTTP requests to be used in by the Google Cloud Storage wrapper.
  """

  alias HTTPoison, as: HTTP
  alias HTTPoison.HTTPResponse
  alias GCloudex.Auth, as: Auth
  import GCloudex, only: [project_id: 0]

  @endpoint "storage.googleapis.com"

  @doc"""
  Sends an HTTP request according to the Service resource in the Google Cloud
  Storage documentation.
  """
  @spec request_service :: HTTPResponse.t
  def request_service do
    HTTP.request(
      :get,
      @endpoint,
      "",
      [
        {"x-goog-project-id", project_id},
        {"Authorization", "Bearer #{Auth.get_token_storage(:full_control)}"}
      ],
      []
    )
  end

  @doc"""
  Sends an HTTP request without any query parameters.
  """
  @spec request(atom, binary, list(tuple), binary) :: HTTPResponse.t
  def request(verb, bucket, headers \\ [], body \\ "") do
    HTTP.request(
      verb,
      bucket <> "." <> @endpoint,
      body,
      headers ++ [{"Authorization",
                   "Bearer #{Auth.get_token_storage(:full_control)}"}],
      []
    )
  end

  @doc"""
  Sends an HTTP request with the specified query parameters.
  """
  @spec request_query(atom, binary, list(tuple), binary, binary) :: HTTPResponse.t
  def request_query(verb, bucket, headers \\ [], body \\ "", parameters) do
    HTTP.request(
      verb,
      bucket <> "." <> @endpoint <> "/" <> parameters,
      body,
      headers ++ [{"Authorization",
                   "Bearer #{Auth.get_token_storage(:full_control)}"}],
      []
    )
  end

  defoverridable [
    request_service: 0,
    request: 3,
    request: 4,
    request_query: 5
  ]
end
