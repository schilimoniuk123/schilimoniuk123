defmodule SamplesOnlineWeb.GenreController do
  use SamplesOnlineWeb, :controller

  alias SamplesOnline.MusicRepo.SampleService
  alias SamplesOnline.MusicRepo.GenreService
  alias SamplesOnline.MusicRepo.CategoryService
  alias SamplesOnline.MusicRepo.Genre

  def index(conn, %{"genreid" => aname} = params) do
    genre = GenreService.get_genre(String.to_integer(aname))
    render(conn, "category.html", genre: genre)  
  end

  def index(conn, %{"categoryid" => aname} = params) do
    category = CategoryService.get_category(String.to_integer(aname))
    render(conn, "sample.html", category: category)
  end

  def index(conn, _params) do
    genres = GenreService.list_genres()
    render(conn, "index.html", genres: genres)
  end

  ###################################################################################

  def index(conn, %{"genre_name" => aname} = params) do
    if String.length(aname) === 0 do
      genres = GenreService.list_genres()
      render(conn, "index.html", genres: genres)
    else
      genres = [GenreService.get_genre(String.to_integer(aname))]
      render(conn, "index.html", genres: genres)
    end
  end

  def index(conn, _params) do
    genres = GenreService.list_genres()
    render(conn, "index.html", genres: genres)
  end

  def new(conn, _params) do
    changeset = GenreService.change_genre(%Genre{})
    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    genre = GenreService.get_genre(id)
    changeset = GenreService.change_genre(genre)
    render(conn, "edit.html", genre: genre, changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    genre = GenreService.get_genre(id)
    render(conn, "show.html", genre: genre)
  end

  
  def update(conn, %{"id" => id, "genre" => genre_params}) do
    genre = GenreService.get_genre(id)

    case GenreService.update_genre(genre, genre_params) do
      {:ok, genre} ->
        conn
        |> put_flash(:info, "genre updated successfully.")
        |> redirect(to: Routes.genre_path(conn, :show, genre))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", genre: genre, changeset: changeset)
    end
  end

  
  def create(conn, %{"genre" => genre_params}) do
    case GenreService.create_genre(genre_params) do
      {:ok, genre} ->
        conn
        |> put_flash(:info, "genre created successfully.")
        |> redirect(to: Routes.genre_path(conn, :index))
    end
  end

  def delete(conn, %{"id" => id}) do
    genre = GenreService.get_genre(id)
    {:ok, _genre} = GenreService.delete_genre(genre)

    conn
    |> put_flash(:info, "genre deleted successfully.")
    |> redirect(to: Routes.genre_path(conn, :index))
  end


   #################################################################

   def loadCategories(conn, %{"genre_id" => id}) do
    genre = GenreService.get_genre(id)
    categories = CategoryService.list_categories()
    render(conn, "categories.html", genre: genre, categories: categories)
  end
  
  def addCategories(conn, %{"genre_id" => genreid, "category_id" => categoryid}) do
    genre = GenreService.get_genre(genreid)
    categories = CategoryService.list_categories()
    category = CategoryService.get_category(categoryid)
    GenreService.assign_category_to_genre(genre, category)
    render(conn, "categories.html", genre: genre, categories: categories)
  end



end
    