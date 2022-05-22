defmodule SamplesOnlineWeb.ApiSampletagView do
  use SamplesOnlineWeb, :view

  alias SamplesOnlineWeb.ApiSampletagView


  def render("index.json", %{sampletags: sampletags}) do
    %{data: render_many(sampletags, ApiSampletagView, "sampletags.json")}
  end

  def render("show.json", %{sampletag: sampletag}) do
    %{data: render_many(sampletag, ApiSampletagView, "sampletag.json", as: :sampletag)}
  end

  def render("sampletag.json", %{sampletag: sampletag}) do
    %{id: sampletag.id, name: sampletag.tagname}
  end
end
