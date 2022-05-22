defmodule SamplesOnlineWeb.Router do
  use SamplesOnlineWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SamplesOnlineWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SamplesOnlineWeb.Plugs.Locale #This is new
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug SamplesOnlineWeb.Pipeline
    plug SamplesOnlineWeb.Plugs.CurrentUser
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :allowed_for_users do
    plug SamplesOnlineWeb.Plugs.AuthorizationPlug, ["Admin", "User"]
  end

  pipeline :allowed_for_admins do
    plug SamplesOnlineWeb.Plugs.AuthorizationPlug, ["Admin"]
  end



  ######################################################################################


  scope "/api", SamplesOnlineWeb do
    pipe_through :api


      resources "/categories", ApiCategoryController

      resources "/genres", ApiGenreController

      resources "/samples", ApiSampleController

      resources "/sampletags", ApiSampletagController

  end

######################################################################################




scope "/", SamplesOnlineWeb do
  pipe_through [:browser, :auth]

  get "/", PageController, :index
  get "/login", SessionController, :new
  post "/login", SessionController, :login
  get "/logout", SessionController, :logout
end


  scope "/", SamplesOnlineWeb do
    pipe_through [:browser, :auth, :ensure_auth, :allowed_for_admins]

    get "/samples/new", SampleController, :new
    patch "/samples/:id", SampleController, :update
    put "/samples/:id", SampleController, :update
    delete "/samples/:id", SampleController, :delete
    post "/samples", SampleController, :create
    get "/samples/:id/edit", SampleController, :edit


    get "/admin", PageController, :admin_index
    delete "/admin/samples/:id", SampleController, :delete
    get "/admin/users/:user_id/edit", UserController, :edit
    get "/admin/users/new", UserController, :new
    get "/admin/users/:user_id", UserController, :show
    post "/admin/users", UserController, :create
    patch "/admin/users/:user_id", UserController, :update
    put "/admin/users/:user_id", UserController, :update
    delete "/admin/users/:user_id", UserController, :delete
    get "/admin/users", UserController, :index


    delete "/categories/:id", CategoryController, :delete
    get "/categories/new", CategoryController, :new
    post "/categories", CategoryController, :create
    get "/categories/:id/edit", CategoryController, :edit
    patch "/categories/:id", CategoryController, :update
    put "/categories/:id", CategoryController, :update


    delete "/sampletags/:id", SampletagController, :delete
    get "/sampletags/new", SampletagController, :new
    post "/sampletags", SampletagController, :create
    get "/sampletags/:id/edit", SampletagController, :edit
    patch "/sampletags/:id", SampletagController, :update
    put "/sampletags/:id", SampletagController, :update


    get "/genres/new", GenreController, :new
    post "/genres", GenreController, :create
    delete "/genres/:id", GenreController, :delete
    get "/genres/:id/edit", GenreController, :edit
    patch "/genres/:id", GenreController, :update
    put "/genres/:id", GenreController, :update

    get "/sample/:sample_id", SampleController, :loadSampletags
    post "/samples/:sample_id/:sampletag_id", SampleController, :addSampletags

    get "/genre/:genre_id", GenreController, :loadCategories
    post "/genre/:genre_id/:category_id", GenreController, :addCategories

  end

  scope "/", SamplesOnlineWeb do
    pipe_through [:browser, :auth, :ensure_auth, :allowed_for_users]

    get "/user_scope", PageController, :user_index
    get "/samples", SampleController, :index
    get "/genres", GenreController, :index
    get "/categories", CategoryController, :index

    get "/sampletags", SampletagController, :index
    get "/genres", GenreController, :index


    get "/genres/:id", GenreController, :show
    get "/categories/:id", CategoryController, :show
    get "/samples/:id", SampleController, :show
    get "/sampletags/:id", SampletagController, :show



    get "/get_api_key/:id", ApiKeyController, :show
    get "/generate_api_key/", ApiKeyController, :generate

  end

  # Other scopes may use custom stacks.
  # scope "/api", SamplesOnlineWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SamplesOnlineWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
