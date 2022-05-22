defmodule SamplesOnline.UserContext do
    import Ecto.Query, warn: false
    alias __MODULE__.User
    alias SamplesOnline.Repo
    alias SamplesOnline.UserContext.User
  
    def authenticate_user(username, password) do
      case Repo.get_by(User, username: username) do
        nil ->
            Pbkdf2.no_user_verify()
            {:error, :invalid_user}
  
        user ->
          if Pbkdf2.verify_pass(password, user.hashed_password) do
            {:ok, user}
          else
            {:error, :invalid_credentials}
          end
      end
    end
  
    defdelegate get_acceptable_roles(), to: User
  
    def get_user(id), do: Repo.get(User, id)
  
    @doc "Returns a user changeset"
    def change_user(%User{} = user) do
      user |> User.changeset(%{})
    end

    
    @doc "Creates a user based on some external attributes"
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc "Returns a specific user or raises an error"
  def get_user!(id), do: Repo.get!(User, id)

  @doc "Returns all users in the system"
  def list_users, do: Repo.all(User)

   @doc "Update an existing user with external attributes"
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc "Delete a user"
  def delete_user(%User{} = user), do: Repo.delete(user)

end