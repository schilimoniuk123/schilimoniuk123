defmodule SamplesOnline.Repo.Migrations.CreateSampletagSample do
  use Ecto.Migration

  def change do
    create table(:sampletag_sample) do
      add :sampletag_id, references(:sampletag)
      add :sample_id, references(:sample)
    end
    create unique_index(:sampletag_sample, [:sampletag_id, :sample_id])
  end
end
