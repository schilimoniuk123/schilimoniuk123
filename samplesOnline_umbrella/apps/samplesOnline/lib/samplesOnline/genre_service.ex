defmodule SamplesOnline.MusicRepo.GenreService do
    import Ecto.Query, warn: false
    alias SamplesOnline.Repo
    alias SamplesOnline.MusicRepo.Genre
    alias SamplesOnline.MusicRepo.Category
    alias SamplesOnline.MusicRepo.Sample
    
    #get all genre
    def list_genres do 
        Genre
        |> Repo.all()
        |> Repo.preload([:category])

    end

    #get a specific genre by name
    def get_genre(aname) do
        genre = Repo.get!(Genre, aname)
        Repo.preload(genre, [:category])
    end

    #create a genre
    def create_genre(attrs \\ %{}) do
        %Genre{}
        |> Genre.changeset(attrs)
        |> Repo.insert()
    end

    #update a genre
    def update_genre(%Genre{} = genre, attrs) do
        genre
        |> Genre.changeset(attrs)
        |> Repo.update()
    end

    #delete a genre
    def delete_genre(%Genre{} = genre) do
        Repo.delete(genre)
    end

    def change_genre(%Genre{} = genre, attrs \\ %{}) do
        Repo.preload(genre, [:category])
        Genre.changeset(genre, attrs)
    end
    
    def assign_category_to_genre(genre, category) do
        Genre.assign_category_to_genre_changeset(genre, category)
        |> Repo.update()
    end



end