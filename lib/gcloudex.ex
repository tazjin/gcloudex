defmodule GCloudex do
  @moduledoc """
  Set of wrappers for Google Cloud Platform's services API's.
  """

  @doc """
  Fetches the Google Project ID from Goth.
  Goth retrieves this either through the configured credentials or from Google's
  metadata service if the application is running on Google Cloud Platform.
  """
  @spec get_project_id :: binary
  def get_project_id do
    {:ok, project_id} = Goth.Config.get(:project_id)
    project_id
  end
end
