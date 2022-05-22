defmodule SamplesOnlineWeb.FallbackController do
  use SamplesOnlineWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_flash(:info, "Changeset error")
    |> render("index.html", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_flash(:info, "Not found")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> redirect(to: Routes.page_path(conn, :unauthorized))
  end


end
