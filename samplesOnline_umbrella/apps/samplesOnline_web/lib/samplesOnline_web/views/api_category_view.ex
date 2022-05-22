defmodule SamplesOnlineWeb.ApiCategoryView do
  use SamplesOnlineWeb, :view
  alias SamplesOnlineWeb.ApiCategoryView

  def render("index.json", %{categories: categories}) do
    %{data: render_many(categories, ApiCategoryView, "categories.json")}
  end

  def render("show.json", %{category: category}) do
    %{data: render_one(category, ApiCategoryView, "category.json"), as: :category}
  end

  def render("category.json", %{category: category}) do
    %{id: category.id, name: category.name}
  end
end
