defmodule SamplesOnline.MusicRepo.Genre do
  use Ecto.Schema
  import Ecto.Changeset
  alias SamplesOnline.MusicRepo.Category

  schema "genre" do
    field :name, :string
    many_to_many :category, Category, join_through: "genre_categorie"
  end

  @doc false
  def changeset(genre, attrs) do
    genre
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def assign_category_to_genre_changeset(genre, categoryy) do
    new_category =[categoryy | genre.category]
    genre
    |> cast(%{}, [])
    |> put_assoc(:category, new_category)
  end
end
