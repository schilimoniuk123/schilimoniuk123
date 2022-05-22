defmodule SamplesOnline.MusicRepo.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias SamplesOnline.MusicRepo.Sample
  alias SamplesOnline.MusicRepo.Genre


  schema "category" do
    field :name, :string
    has_many :sample, Sample
    many_to_many :genre, Genre, join_through: "genre_categorie"
  end


  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
