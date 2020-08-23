defmodule PhoenixChat.Users do
  import Ecto.Query, warn: false
  alias PhoenixChat.Repo

  alias PhoenixChat.Users.User

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
