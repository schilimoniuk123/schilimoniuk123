defmodule SamplesOnline.Repo.Migrations.CreateSample do
  use Ecto.Migration

  def change do
    create table(:sample) do
      add :name, :string
      add :duration, :string
      add :bpm, :integer
      add :category_id, references(:category)
    end
    create index(:sample, [:category_id])
  end
end
