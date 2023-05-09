defmodule LightAppWeb.LightLive do
  use LightAppWeb, :live_view

  #INIT STATES
  #SOCKET HANDLES STATE
  def mount(_params, _session, lightStates) do
    IO.inspect(lightStates)
    {:ok, assign(lightStates, brightness: 10)}
  end

  # What shows on the page
  def render(assigns) do
    ~H"""
    <div class="w-full h-full gap-5 justify-center items-center">
    <div class="w-fit h-fit flex flex-col items-center justify-center">
        <p class="text-[40px]">Welcome to my Light Playground 😄</p>

        <div class="flex flex-col items-center justify-center gap-2">
          <div class="flex flex-row gap-2">
          <p>Current brightness:</p>
          <p>
          <%= @brightness %>%
          </p>
          </div>

          <div>
            <button class="border border-2 border-[#000000] p-3 rounded-lg hover:bg-[#808080]" phx-click="on">☀️ Light on</button>
            <button class="border border-2 border-[#000000] p-3 rounded-lg hover:bg-[#808080]" phx-click="off">🌙 Light off</button>
            <button class="border border-2 border-[#000000] p-3 rounded-lg hover:bg-[#808080]" phx-click="increase_by_10">+10 %</button>
            <button class="border border-2 border-[#000000] p-3 rounded-lg hover:bg-[#808080]" phx-click="decrease_by_10">-10 %</button>
          </div>
        </div>

    </div>


    </div>



    """
  end


  #FUNCTIONS

  #on function for line 20
  def handle_event("on", _, lightStates) do
    IO.inspect(lightStates)
    lightStates = assign(lightStates, brightness: 100)
    {:noreply, lightStates}
  end

  #off function for line 22
  def handle_event("off", _, lightStates) do
    lightStates = assign(lightStates, brightness: 0)
    {:noreply, lightStates}
  end

  #increase by 10%
  def handle_event("increase_by_10", _, lightStates) do
    lightStates = update(lightStates, :brightness, fn currBrightness ->
      if currBrightness + 10 > 100 do
        currBrightness
      else
        currBrightness + 10
      end
    end)
    {:noreply, lightStates}
  end


  #increase by 10%
  def handle_event("decrease_by_10", _, lightStates) do
    lightStates = update(lightStates, :brightness, fn currBrightness ->
      if currBrightness - 10 < 0 do
        currBrightness
      else
        currBrightness - 10
      end
    end)
    {:noreply, lightStates}
  end
end
