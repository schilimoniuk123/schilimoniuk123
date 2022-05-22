defmodule SamplesOnlineWeb.ApiGenreView do
  use SamplesOnlineWeb, :view

  alias SamplesOnlineWeb.ApiGenreView

  def render("index.json", %{genre: genre}) do
    %{data: render_many(genre, ApiGenreView, "genre.json")}
  end

  def render("show.json", %{genre: genre}) do
    %{data: render_one(genre, ApiGenreView, "genre.json", as: :genre)}
  end

  def render("genre.json", %{genre: genre}) do
    %{id: genre.id, name: genre.name}
  end
end
