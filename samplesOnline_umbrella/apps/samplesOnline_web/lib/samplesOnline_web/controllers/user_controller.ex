defmodule SamplesOnlineWeb.UserController do
    use SamplesOnlineWeb, :controller

    alias SamplesOnline.UserContext
    alias SamplesOnline.UserContext.User

    def new(conn, _parameters) do
      changeset = UserContext.change_user(%User{})
      roles = UserContext.get_acceptable_roles()
      render(conn, "new.html", changeset: changeset, acceptable_roles: roles)
    end

    def create(conn, %{"user" => user_params}) do
      case UserContext.create_user(user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User #{user.username} created successfully.")
          |> redirect(to: Routes.user_path(conn, :new))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end

    def userindex(conn, _params) do
      users = UserContext.list_users()
      render(conn, "user_index.html", users: users)
    end

    def index(conn, _params) do
      users = UserContext.list_users()
      render(conn, "index.html", users: users)
    end

    def usershow(conn, %{"user_id" => id}) do
      user = UserContext.get_user!(id)
      render(conn, "user_show.html", user: user)
    end

    def show(conn, %{"user_id" => id}) do
      user = UserContext.get_user!(id)
      render(conn, "show.html", user: user)
    end

    def edit(conn, %{"user_id" => id}) do
      user = UserContext.get_user!(id)
      changeset = UserContext.change_user(user)
      roles = UserContext.get_acceptable_roles()
      render(conn, "edit.html", user: user, changeset: changeset, acceptable_roles: roles)
    end

    def update(conn, %{"user_id" => id, "user" => user_params}) do
      user = UserContext.get_user!(id)

      case UserContext.update_user(user, user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User updated successfully.")
          |> redirect(to: Routes.user_path(conn, :show, user))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", user: user, changeset: changeset)
      end
    end

    def get_logged_in_user(conn) do
      Guardian.Plug.current_resource(conn)
    end

     def delete(conn, %{"user_id" => id}) do
      user = UserContext.get_user!(id)
      {:ok, _user} = UserContext.delete_user(user)

      conn
      |> put_flash(:info, "User deleted successfully.")
      |> redirect(to: Routes.user_path(conn, :index))
    end
  end
