defmodule SamplesOnline.Repo.Migrations.CreateSampletag do
  use Ecto.Migration

  def change do
    create table(:sampletag) do
      add :tagname, :string
    end
  end
end
