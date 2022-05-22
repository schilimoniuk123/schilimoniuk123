defmodule SamplesOnline.MusicRepo.SampleService do
    import Ecto.Query, warn: false
    alias SamplesOnline.Repo
    alias SamplesOnline.MusicRepo.Sample
    alias SamplesOnline.MusicRepo.Category

    #get all samples
    def list_samples do
        Sample
        |> Repo.all()
        |> Repo.preload([:category, :sampletag])
    end

    #get a specific sample by name
    def get_sample(name) do
        sample = Repo.get!(Sample, name)
        samples = Repo.preload(sample, [:sampletag, :category])
    end
    #create a sample
    def create_sample(attrs, category) do
        %Sample{}
        |> Sample.create_changeset(attrs, category)
        |> Repo.insert()
    end


    #update a sample
    def update_sample(%Sample{} = sample, attrs) do
        sample
        |> Sample.changeset(attrs)
        |> Repo.update()
    end

    #delete a sample
    def delete_sample(%Sample{} = sample) do
        Repo.preload(sample, [:sampletag, :category])
        Repo.delete(sample)
    end

    def change_sample(%Sample{} = sample, attrs \\ %{}) do
        Repo.preload(sample, [:category, :sampletag])
        Sample.changeset(sample, attrs)
    end

    def assign_tag_to_sample(sample, sampletag) do
        Sample.assign_sampletag_to_sample_changeset(sample, sampletag)
        |> Repo.update()
    end

end
