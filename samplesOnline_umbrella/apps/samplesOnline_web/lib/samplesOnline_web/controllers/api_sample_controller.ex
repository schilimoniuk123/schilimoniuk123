defmodule SamplesOnlineWeb.ApiSampleController do
  use SamplesOnlineWeb, :controller

  alias SamplesOnline.MusicRepo.CategoryService
  alias SamplesOnline.MusicRepo.SampleService
  alias SamplesOnline.MusicRepo.SampletagService
  alias SamplesOnline.MusicRepo.GenreService

  alias SamplesOnline.MusicRepo.Category

  action_fallback UserCatsWeb.FallbackController

  def index(conn, %{"api_sample_id" => aname} = params) do
    if String.length(aname) === 0 do
      samples = SampleService.list_samples()
      render(conn, "index.json", samples: samples)
    else
      samples = [SampleService.get_sample(String.to_integer(aname))]
      render(conn, "index.json", samples: samples)
    end
  end
  #def index(conn, %{"api_sample_id" => sample_id}) do
  #  sample = SampleService.get_sample(String.to_integer(sample_id))
  #  render(conn, "index.json", sample: sample)
  #end

  def create(conn, %{"sample" => sample_params}) do
    category = CategoryService.get_category(sample_params["category_id"])

    case SampleService.create_sample(sample_params, category)do
      {:ok, sample} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.sample_path(conn, :show, sample))
        |> render("show.json", sample: sample)

      {:error, _cs} ->
        conn
        |> send_resp(400, "Something went wrong, sorry. Adjust your parameters or give up.")
    end
  end

  def show(conn, %{"id" => id}) do
    sample = SampleService.get_sample(id)
    render(conn, "show.json", sample: sample)
  end

  def update(conn, %{"id" => id, "sample" => sample_params}) do
    sample = SampleService.get_sample(id)

    case SampleService.update_sample(sample, sample_params) do
      {:ok, sample} ->
        render(conn, "show.json", sample: sample)

      {:error, _cs} ->
        conn
        |> send_resp(400, "Something went wrong, sorry. Adjust your parameters or give up.")
    end
  end

  def delete(conn, %{"id" => id}) do
    sample = SampleService.get_sample(id)

    with {:ok, _sample} <- SampleService.delete_sample(sample) do
      send_resp(conn, :no_content, "")
    end
  end


end
