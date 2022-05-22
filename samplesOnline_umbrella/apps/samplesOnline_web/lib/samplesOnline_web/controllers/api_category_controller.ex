defmodule SamplesOnlineWeb.ApiCategoryController do
  use SamplesOnlineWeb, :controller

  alias SamplesOnline.MusicRepo.CategoryService
  alias SamplesOnline.MusicRepo.SampleService
  alias SamplesOnline.MusicRepo.SampletagService
  alias SamplesOnline.MusicRepo.GenreService

  alias SamplesOnline.MusicRepo.Category

  action_fallback UserCatsWeb.FallbackController

  def index(conn, %{"category_name" => aname}) do
    if String.length(aname) === 0 do
      categories = CategoryService.list_categories()
      render(conn, "index.json", categories: categories)
    else
      categories = [CategoryService.get_category(String.to_integer(aname))]
      render(conn, "index.json", categories: categories)
    end
  end

  def create(conn, %{"category" => category_params}) do
    case CategoryService.create_category(category_params) do
      {:ok, category} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.category_path(conn, :show, category))
        |> render("show.json", category: category)

      {:error, _cs} ->
        conn
        |> send_resp(400, "Something went wrong, sorry. Adjust your parameters or give up.")
    end
  end

  def show(conn, %{"id" => id}) do
    category = CategoryService.get_category(id)
    render(conn, "show.json", category: category)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = CategoryService.get_category(id)

    case CategoryService.update_category(category, category_params) do
      {:ok, category} ->
        render(conn, "show.json", category: category)
        {:error, _cs} ->
          conn
          |> send_resp(400, "Something went wrong, sorry. Adjust your parameters or give up.")
    end
  end

  def delete(conn, %{"id" => id}) do
    category = CategoryService.get_category(id)
    with {:ok, _category} <- CategoryService.delete_category(category) do
      send_resp(conn, :no_content, "")
    end
  end



end
