defmodule Discuss.UserSocket do
  use Phoenix.Socket

  channel "comments:*", Discuss.CommentsChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(%{"token" => token}, socket) do
    IO.puts token
    {:ok, socket}
  end

  def id(_socket), do: nil
end
