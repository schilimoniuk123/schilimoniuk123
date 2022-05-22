defmodule SamplesOnlineWeb.Plugs.CurrentUser do
  import Plug.Conn
  import Guardian.Plug


  def init(options), do: options


  def call(conn, _options) do
    current_user = current_resource(conn)
    assign(conn, :current_user, current_user)
  end
end
