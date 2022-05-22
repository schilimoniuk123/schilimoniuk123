defmodule SamplesOnline.Repo do
  use Ecto.Repo,
    otp_app: :samplesOnline,
    adapter: Ecto.Adapters.Postgres
end
