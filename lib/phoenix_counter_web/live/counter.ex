defmodule PhoenixCounterWeb.Counter do
  use PhoenixCounterWeb, :live_view

  @topic "live"

  def mount(_params, _session, socket) do
    if connected?(socket) do
      PhoenixCounterWeb.Endpoint.subscribe(@topic)
    end

    {:ok, assign(socket, :val, 0)}
  end

  def handle_event("inc", _value, socket) do
    new_state = update(socket, :val, &(&1 + 1))
    PhoenixCounterWeb.Endpoint.broadcast_from(self(), @topic, "inc", new_state.assigns)

    {:noreply, new_state}
  end

  def handle_event("dec", _value, socket) do
    new_state = update(socket, :val, &(&1 - 1))
    PhoenixCounterWeb.Endpoint.broadcast_from(self(), @topic, "dec", new_state.assigns)

    {:noreply, new_state}
  end

  def handle_info(msg, socket) do
    {:noreply, assign(socket, :val, msg.payload.val)}

  end


  def render(assigns) do
    ~H"""
      <div class="text-center">
      <h1 class="text-8xl font-bold text-center mb-10"> Counter: <%= @val %> </h1>
      <.button phx-click="dec" class="w-20 bg-red-500 hover:bg-red-600">-</.button>
      <.button phx-click="inc" class="w-20 bg-green-500 hover:bg-green-600">+</.button>
    </div>
    """
  end
end
