defmodule SamplesOnline.MusicRepo.Sample do
  use Ecto.Schema
  import Ecto.Changeset
  alias SamplesOnline.MusicRepo.Category
  alias SamplesOnline.MusicRepo.Sampletag


  schema "sample" do
    field :bpm, :integer
    field :duration, :string
    field :name, :string
    belongs_to :category, Category, foreign_key: :category_id
    many_to_many :sampletag, Sampletag, join_through: "sampletag_sample"
  end


  @doc false
  def changeset(sample, attrs) do
    sample
    |> cast(attrs, [:name, :duration, :bpm])
    |> validate_required([:name, :duration, :bpm])
  end


  @doc false
  def create_changeset(sample, attrs, category) do
    sample
    |> cast(attrs, [:name, :duration, :bpm, :category_id])
    |> validate_required([:name, :duration, :bpm, :category_id])
    |> put_assoc(:category, category)
  end


  def assign_sampletag_to_sample_changeset(sample, sampletagee) do
    new_sampletags =[sampletagee | sample.sampletag]
    sample
    |> cast(%{}, [])
    |> put_assoc(:sampletag, new_sampletags)
  end


  def create_changeset_sampletag(sample, attrs, sampletag) do
    sample
    |> cast(attrs, [:name, :duration, :bpm])
    |> validate_required([:name, :duration, :bpm,])
    |> put_assoc(:category, sampletag)
  end


  #def update_changeset(sample, attrs, category) do
  #  sample
  #  |> Repo.preload(:comment)
  #  |> cast(attrs, [:title, :body])
  #  |> put_assoc(:category, category)
  #  |> cast_assoc(:comment, required: true, on_replace: :nilify)
  #end



end
