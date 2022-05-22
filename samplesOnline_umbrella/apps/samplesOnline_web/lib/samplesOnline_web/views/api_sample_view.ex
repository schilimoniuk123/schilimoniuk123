defmodule SamplesOnlineWeb.ApiSampleView do
  use SamplesOnlineWeb, :view

  alias SamplesOnlineWeb.ApiSampleView

  def render("index.json", %{samples: samples}) do
    %{data: render_many(samples, ApiSampleView, "index.json")}

  end

  def render("show.json", %{sample: sample}) do
    %{data: render_one(sample, ApiSampleView, "sample.json", as: :sample)}
  end

  def render("sample.json", %{sample: sample}) do
    %{id: sample.id, name: sample.name}
  end
end
