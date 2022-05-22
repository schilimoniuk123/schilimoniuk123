defmodule SamplesOnlineWeb.CategoryController do
  use SamplesOnlineWeb, :controller

  alias SamplesOnline.MusicRepo.CategoryService
  alias SamplesOnline.MusicRepo.Category

  def index(conn, %{"category_name" => aname} = params) do
    if String.length(aname) === 0 do
      categories = CategoryService.list_categories()
      render(conn, "index.html", categories: categories)
    else
      categories = [CategoryService.get_category(String.to_integer(aname))]
      render(conn, "index.html", categories: categories)
    end
  end

  def edit(conn, %{"id" => id}) do
    category = CategoryService.get_category(id)
    changeset = CategoryService.change_category(category)
    render(conn, "edit.html", category: category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = CategoryService.get_category(id)

    case CategoryService.update_category(category, category_params) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "category updated successfully.")
        |> redirect(to: Routes.category_path(conn, :show, category))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", category: category, changeset: changeset)
    end
  end

  def index(conn, _params) do
    categories = CategoryService.list_categories()
    render(conn, "index.html", categories: categories)
  end

  def show(conn, %{"id" => id}) do
    category = CategoryService.get_category(id)
    render(conn, "show.html", category: category)
  end

  def new(conn, _params) do
    changeset = CategoryService.change_category(%Category{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"category" => category_params}) do
    case CategoryService.create_category(category_params) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "category created successfully.")
        |> redirect(to: Routes.category_path(conn, :index))
    end
  end

  def delete(conn, %{"id" => id}) do
    category = CategoryService.get_category(id)
    {:ok, _category} = CategoryService.delete_category(category)

    conn
    |> put_flash(:info, "category deleted successfully.")
    |> redirect(to: Routes.category_path(conn, :index))
  end


end
