defmodule PhoenixChatWeb.RoomChannel do
  use PhoenixChatWeb, :channel

  @impl true
  def join("room:lobby", _, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end
end
