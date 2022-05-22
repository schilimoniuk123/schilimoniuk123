defmodule SamplesOnlineWeb.ApiSampletagController do
  use SamplesOnlineWeb, :controller
  alias SamplesOnline.MusicRepo.SampleService
  alias SamplesOnline.MusicRepo.SampletagService
  alias SamplesOnline.MusicRepo.Sampletag

  action_fallback UserCatsWeb.FallbackController

  def index(conn, %{"sampletag_name" => aname} = params) do
    if String.length(aname) === 0 do
        sampletags = SampletagService.list_sampletags()
        render(conn, "index.json", sampletags: sampletags)
    else
        sampletags = [SampletagService.get_sampletag(String.to_integer(aname))]
        render(conn, "index.json", sampletags: sampletags)
    end
end

  def create(conn, %{"sampletag" => sampletag_params}) do

    case SampletagService.create_sampletag(sampletag_params) do
      {:ok, sampletag} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.sampletag_path(conn, :show, sampletag))
        |> render("show.json", sampletag: sampletag)

      {:error, _cs} ->
        conn
        |> send_resp(400, "Something went wrong, sorry. Adjust your parameters or give up.")
    end
  end


  def show(conn, %{"id" => id}) do
    sampletag = SampletagService.get_sampletag(id)
    render(conn, "show.json", sampletag: sampletag)
  end

  def update(conn, %{"id" => id, "sampletag" => sampletag_params}) do
    sampletag = SampletagService.get_sampletag(id)

    case SampletagService.update_sampletag(sampletag, sampletag_params) do
      {:ok, sampletag} ->
        render(conn, "show.json", sampletag: sampletag)

      {:error, _cs} ->
        conn
        |> send_resp(400, "Something went wrong, sorry. Adjust your parameters or give up.")
    end
  end

  def delete(conn, %{"id" => id}) do
    sampletag = SampletagService.get_sampletag(id)

    with {:ok,_sampletag} <- SampletagService.delete_sampletag(sampletag) do
      send_resp(conn, :no_content, "")
    end
  end



end
