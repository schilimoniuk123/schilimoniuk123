defmodule SamplesOnline.Repo.Migrations.CreateGenre do
  use Ecto.Migration

  def change do
    create table(:genre) do
      add :name, :string
    end
  end
end
