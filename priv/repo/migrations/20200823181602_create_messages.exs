defmodule PhoenixChat.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :name, :string, null: false
      add :message, :text, null: false

      timestamps()
    end
  end
end
