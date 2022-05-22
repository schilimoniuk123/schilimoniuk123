defmodule SamplesOnlineWeb.SampletagController do
    use SamplesOnlineWeb, :controller

    alias SamplesOnline.MusicRepo.SampleService
    alias SamplesOnline.MusicRepo.SampletagService
    alias SamplesOnline.MusicRepo.Sampletag

    def index(conn, %{"sampletag_name" => aname} = params) do
        if String.length(aname) === 0 do
        sampletags = SampletagService.list_sampletags()
        render(conn, "index.html", sampletags: sampletags)
        else
        sampletags = [SampletagService.get_sampletag(String.to_integer(aname))]
        render(conn, "index.html", sampletags: sampletags)
        end
    end

    def index(conn, _params) do
        sampletags = SampletagService.list_sampletags()
        render(conn, "index.html", sampletags: sampletags)
    end


    def edit(conn, %{"id" => id}) do
        sampletag = SampletagService.get_sampletag(id)
        changeset = SampletagService.change_sampletag(sampletag)
        render(conn, "edit.html", sampletag: sampletag, changeset: changeset)
    end

    def update(conn, %{"id" => id, "sampletag" => sampletag_params}) do
        sampletag = SampletagService.get_sampletag(id)
        case SampletagService.update_sampletag(sampletag, sampletag_params) do
          {:ok, sampletag} ->
            conn
            |> put_flash(:info, "sampletag updated successfully.")
            |> redirect(to: Routes.sampletag_path(conn, :show, sampletag))

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "edit.html", sampletag: sampletag, changeset: changeset)
        end
      end


    def show(conn, %{"id" => id}) do
        sampletag = SampletagService.get_sampletag(id)
        render(conn, "show.html", sampletag: sampletag)
    end


    def new(conn, _params) do
        changeset = SampletagService.change_sampletag(%Sampletag{})
        render(conn, "new.html", changeset: changeset)
    end

    def create(conn, %{"sampletag" => sampletag_params}) do
        case SampletagService.create_sampletag(sampletag_params) do
        {:ok, sampletag} ->
            conn
            |> put_flash(:info, "Sample created successfully.")
            |> redirect(to: Routes.sampletag_path(conn, :index))

        end
    end

    def delete(conn, %{"id" => id}) do
        sampletag = SampletagService.get_sampletag(id)
        {:ok, _sampletag} = SampletagService.delete_sampletag(sampletag)

        conn
        |> put_flash(:info, "sampletag deleted successfully.")
        |> redirect(to: Routes.sampletag_path(conn, :index))
    end


end
