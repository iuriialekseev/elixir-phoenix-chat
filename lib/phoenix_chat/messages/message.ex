defmodule PhoenixChat.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhoenixChat.Users.User

  schema "messages" do
    field :text, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:text, :user_id])
    |> validate_required([:text, :user_id])
  end
end
