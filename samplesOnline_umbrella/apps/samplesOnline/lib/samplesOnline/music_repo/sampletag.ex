defmodule SamplesOnline.MusicRepo.Sampletag do
  use Ecto.Schema
  import Ecto.Changeset
  alias SamplesOnline.MusicRepo.Sample

  schema "sampletag" do
    field :tagname, :string
    many_to_many :sample, Sample, join_through: "sampletag_sample"
  end

  @doc false
  def changeset(sampletag, attrs) do
    sampletag
    |> cast(attrs, [:tagname])
    |> validate_required([:tagname])
  end
end
