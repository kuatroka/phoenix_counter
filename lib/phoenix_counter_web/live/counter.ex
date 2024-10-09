defmodule PhoenixCounterWeb.Counter do
  use PhoenixCounterWeb, :live_view
  alias Counter.Count
  alias Phoenix.PubSub

  @topic Count.topic

  def mount(_params, _session, socket) do
    val = Count.current()  # Get the current value
    if connected?(socket) do
      PubSub.subscribe(PhoenixCounter.PubSub, @topic)  # Corrected PubSub name
      {:ok, assign(socket, val: val)}
    else
      {:ok, assign(socket, val: val)}  # Assign default value when not connected
    end
  end

  def handle_event("inc", %{"value" => _value}, socket) do
    {:noreply, assign(socket, :val, Count.incr())}
  end

  def handle_event("dec", %{"value" => _value}, socket) do
    {:noreply, assign(socket, :val, Count.decr())}
  end

  def handle_info({:count, count}, socket) do
    {:noreply, assign(socket, val: count)}
  end

  def render(assigns) do
    ~H"""
    <.live_component module={CounterComponent} id="counter" val={@val} />
    """
  end
end
