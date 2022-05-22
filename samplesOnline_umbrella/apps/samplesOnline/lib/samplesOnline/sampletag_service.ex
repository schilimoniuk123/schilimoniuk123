defmodule SamplesOnline.MusicRepo.SampletagService do
    import Ecto.Query, warn: false
    alias SamplesOnline.Repo
    alias SamplesOnline.MusicRepo.Sampletag

    #get all sampletag
    def list_sampletags do 
        Sampletag
        |> Repo.all()
        |> Repo.preload([:sample])
    end

    #get a specific sampletag by name
    def get_sampletag(name) do
        sampletag = Repo.get!(Sampletag, name)
        sampletag = Repo.preload(sampletag, [:sample])
    end 
    #create a sampletag
    def create_sampletag(attrs \\ %{}) do
        %Sampletag{}
        |> Sampletag.changeset(attrs)
        |> Repo.insert()
    end

    #update a sampletag
    def update_sampletag(%Sampletag{} = sampletag, attrs) do
        sampletag
        |> Sampletag.changeset(attrs)
        |> Repo.update()
    end

    #delete a sampletag
    def delete_sampletag(%Sampletag{} = sampletag) do
        Repo.preload(sampletag, [:sample])
        Repo.delete(sampletag)
    end

    def change_sampletag(%Sampletag{} = sampletag, attrs \\ %{}) do
        Repo.preload(sampletag, [:sample])
        Sampletag.changeset(sampletag, attrs)
    end

end