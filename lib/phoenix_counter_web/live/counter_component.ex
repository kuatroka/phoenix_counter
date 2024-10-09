defmodule CounterComponent do
  use Phoenix.LiveComponent

  # Avoid duplicating Tailwind classes and use full class names:
  defp btn("red"), do: "text-6xl pb-2 w-20 rounded-lg bg-red-500 hover:bg-red-600"
  defp btn("green"), do: "text-6xl pb-2 w-20 rounded-lg bg-green-500 hover:bg-green-600"

  def render(assigns) do
    ~H"""
    <div class="text-center">
      <h1 class="text-4xl font-bold text-center"> Counter : <%= @val %> </h1>
      <button phx-click="dec" class={btn("red")}>
        -
      </button>
      <button phx-click="inc" class={btn("green")}>
        +
      </button>
    </div>
    """
  end
end
