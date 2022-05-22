defmodule SamplesOnline.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :username, :string, null: false
      add :hashed_password, :string, null: false
      add :role, :string, null: false
    end
  end
end
