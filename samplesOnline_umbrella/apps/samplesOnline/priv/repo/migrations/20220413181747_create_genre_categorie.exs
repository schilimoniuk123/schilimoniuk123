defmodule SamplesOnline.Repo.Migrations.CreateGenreCategorie do
  use Ecto.Migration

  def change do
    create table(:genre_categorie) do
      add :genre_id, references(:genre)
      add :category_id, references(:category)
    end
    create unique_index(:genre_categorie, [:genre_id, :category_id])
  end
end
