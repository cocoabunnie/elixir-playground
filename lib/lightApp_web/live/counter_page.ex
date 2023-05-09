defmodule LightAppWeb.CounterPage do
  use LightAppWeb, :live_view

  def mount(_params, _session, counterState) do
    {:ok, assign(counterState, count: 0)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col w-full justify-center items-center">
    <p class="text-[100px]">
      <%= @count %>
    </p>

    <div class="flex flex-row gap-3">
      <button class="border border-2-[#808080] p-3 rounded-lg hover:bg-[#808080]" phx-click="increment">Increment</button>
      <button class="border border-2-[#808080] p-3 rounded-lg hover:bg-[#808080]" phx-click="decrement">Decrement</button>
    </div>

    </div>
    """
  end


  #FUNCTIONS
  def handle_event("increment", _, counterState) do
    counterState = update(counterState, :count, fn currCount ->
      if currCount + 1 <= 50 do
        currCount + 1
      else
        currCount
      end
    end)
    {:noreply, counterState}
  end

  def handle_event("decrement", _, counterState) do
    counterState = update(counterState, :count, fn currCount ->
      if currCount - 1 >= 0 do
        currCount - 1
      else
        currCount
      end
    end)
    {:noreply, counterState}
  end
end
