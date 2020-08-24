defmodule PhoenixChatWeb.RoomChannel do
  use PhoenixChatWeb, :channel
  alias PhoenixChat.Messages

  @impl true
  def join("room:lobby", _, socket) do
    send(self(), :after_join)

    {:ok, socket}
  end

  @impl true
  def handle_in("broadcast", payload, socket) do
    Messages.create_message(payload)
    broadcast(socket, "broadcast", payload)
    {:noreply, socket}
  end

  @impl true
  def handle_info(:after_join, socket) do
    Messages.list_messages()
    |> Enum.each(fn m ->
      push(socket, "broadcast", %{
        name: m.name,
        message: m.message
      })
    end)

    {:noreply, socket}
  end
end
