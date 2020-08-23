defmodule PhoenixChat.Messages do
  import Ecto.Query, warn: false
  alias PhoenixChat.Repo

  alias PhoenixChat.Messages.Message

  def list_messages do
    Repo.all(Message)
  end

  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end
end
