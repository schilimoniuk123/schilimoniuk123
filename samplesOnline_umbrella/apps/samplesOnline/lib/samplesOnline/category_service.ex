defmodule SamplesOnline.MusicRepo.CategoryService do
    import Ecto.Query, warn: false
    alias SamplesOnline.Repo
    alias SamplesOnline.MusicRepo.Category


    #get all category
    def list_categories do
        Category
        |> Repo.all()
        |> Repo.preload([:genre, :sample])
    end

    #get a specific category by name
    def get_category(name) do
        category = Repo.get(Category, name)
        category = Repo.preload(category, [:genre, :sample])
    end
    #create a category
    def create_category(attrs \\ %{}) do
        %Category{}
        |> Category.changeset(attrs)
        |> Repo.insert()
    end

    #update a category
    def update_category(%Category{} = category, attrs) do
        category
        |> Category.changeset(attrs)
        |> Repo.update()
    end

    #delete a category
    def delete_category(%Category{} = category) do
        Repo.preload(category, [:sample, :genre])
        Repo.delete(category)
    end

    def change_category(%Category{} = category, attrs \\ %{}) do
        Repo.preload(category, [:sample, :genre])
        Category.changeset(category, attrs)
    end

end
