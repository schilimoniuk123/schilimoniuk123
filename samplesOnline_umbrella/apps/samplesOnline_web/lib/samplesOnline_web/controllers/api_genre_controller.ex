defmodule SamplesOnlineWeb.ApiGenreController do
  use SamplesOnlineWeb, :controller

  alias SamplesOnline.MusicRepo.SampleService
  alias SamplesOnline.MusicRepo.GenreService
  alias SamplesOnline.MusicRepo.CategoryService
  alias SamplesOnline.MusicRepo.Genre

  action_fallback UserCatsWeb.FallbackController

  def index(conn, %{"genreid" => aname} = params) do
    genre = GenreService.get_genre(String.to_integer(aname))
    render(conn, "index.json", genre: genre)
  end

  def create(conn, %{"genre" => genre_params}) do
    case GenreService.create_genre(genre_params) do
      {:ok,genre} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.genre_path(conn, :show, genre))
        |> render("show.json", genre: genre)

      {:error, _cs} ->
        conn
        |> send_resp(400, "Something went wrong, sorry. Adjust your parameters or give up.")
    end
  end
  def show(conn, %{"id" => id}) do
    genre = GenreService.get_genre(id)
    render(conn, "show.json", genre: genre)
  end

  def update(conn, %{"id" => id, "genre" => genre_params}) do
    genre = GenreService.get_genre(id)

    case CatContext.update_genre(genre, genre_params) do
      {:ok, genre} ->
        render(conn, "show.json", genre: genre)

      {:error, _cs} ->
        conn
        |> send_resp(400, "Something went wrong, sorry. Adjust your parameters or give up.")
    end
  end

  def delete(conn, %{"id" => id}) do
    genre = GenreService.get_genre(id)

    with {:ok, _genre} <- GenreService.delete_genre(genre) do
      send_resp(conn, :no_content, "")
    end
  end

end
