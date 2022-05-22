defmodule SamplesOnlineWeb.SampleController do
  use SamplesOnlineWeb, :controller

  alias SamplesOnline.MusicRepo.SampleService
  alias SamplesOnline.MusicRepo.SampletagService
  alias SamplesOnline.MusicRepo.CategoryService
  alias SamplesOnline.MusicRepo.Sample

  def index(conn, %{"sample_name" => aname} = params) do
    if String.length(aname) === 0 do
      samples = SampleService.list_samples()
      render(conn, "index.html", samples: samples)
    else
      samples = [SampleService.get_sample(String.to_integer(aname))]
      render(conn, "index.html", samples: samples)
    end
  end

  def index(conn, _params) do
    samples = SampleService.list_samples()
    render(conn, "index.html", samples: samples)
  end

  def edit(conn, %{"id" => id}) do
    sample = SampleService.get_sample(id)

    changeset = SampleService.change_sample(sample)
    render(conn, "edit.html", sample: sample, changeset: changeset)
  end


  def update(conn, %{"id" => id, "sample" => sample_params}) do
    sample = SampleService.get_sample(id)

    case SampleService.update_sample(sample, sample_params) do
      {:ok, sample} ->
        conn
        |> put_flash(:info, "sample updated successfully.")
        |> redirect(to: Routes.sample_path(conn, :show, sample))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sample: sample, changeset: changeset)
    end
  end
  def show(conn, %{"id" => id}) do
    sample = SampleService.get_sample(id)
    render(conn, "show.html", sample: sample)
  end

  def new(conn, _params) do
    changeset = SampleService.change_sample(%Sample{})
    categories = CategoryService.list_categories()
    render(conn, "new.html", changeset: changeset, categories: categories )
  end

  def create(conn, %{"sample" => sample_params}) do

    category = CategoryService.get_category(sample_params["category_id"])

    case SampleService.create_sample(sample_params, category) do
      {:ok, _sample} ->
        conn
        |> put_flash(:info, "Sample created successfully.")
        |> redirect(to: Routes.sample_path(conn, :index))
    end
  end

  def delete(conn, %{"id" => id}) do
    sample = SampleService.get_sample(id)
    {:ok, _sample} = SampleService.delete_sample(sample)

    conn
    |> put_flash(:info, "sample deleted successfully.")
    |> redirect(to: Routes.sample_path(conn, :index))
  end

  #################################################################

  def loadSampletags(conn, %{"sample_id" => id}) do
    sample = SampleService.get_sample(id)
    sampletags = SampletagService.list_sampletags()
    render(conn, "sampletags.html", sample: sample, sampletags: sampletags)
  end

  def addSampletags(conn, %{"sample_id" => sampleid, "sampletag_id" => sampletagid}) do
    sample = SampleService.get_sample(sampleid)
    sampletags = SampletagService.list_sampletags()
    sampletag = SampletagService.get_sampletag(sampletagid)
    SampleService.assign_tag_to_sample(sample, sampletag)
    render(conn, "sampletags.html", sample: sample, sampletags: sampletags)
  end


end
