defmodule LightAppWeb.LightLive do
  use LightAppWeb, :live_view

  # INIT STATES
  # SOCKET HANDLES STATE
  def mount(_params, _session, lightStates) do
    IO.inspect(lightStates)
    {:ok, assign(lightStates, brightness: 10, lightColor: "#FFFF00")}
  end

  def render(assigns) do
    ~H"""
    <div class="w-screen h-screen gap-5 flex justify-center items-center">
      <div
        class="absolute w-screen h-screen -z-[1]"
        style={"background-color:#{@lightColor}; opacity: #{@brightness/100}"}
      />

      <div class="absolute flex flex-col border border-2 border-[#000000] p-3 rounded-lg top-16 left-10">
        <p class="mb-2">Pick a color!</p>

        <div class="flex flex-col gap-3">
          <button class="hover:animate-bounce" phx-click="changeColorToYellow">Yellow</button>
          <button class="hover:animate-bounce" phx-click="changeColorToPink">Pink</button>
          <button class="hover:animate-bounce" phx-click="changeColorToBlue">Blue</button>
          <button class="hover:animate-bounce" phx-click="changeColorToPurple">Purple</button>
        </div>
      </div>

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
            <button
              class="bg-[#ffffff] border border-2 border-[#000000] p-3 rounded-lg hover:bg-[#808080]"
              phx-click="on"
            >
              ☀️ Light on
            </button>
            <button
              class="bg-[#ffffff] border border-2 border-[#000000] p-3 rounded-lg hover:bg-[#808080]"
              phx-click="off"
            >
              🌙 Light off
            </button>
            <button
              class="bg-[#ffffff] border border-2 border-[#000000] p-3 rounded-lg hover:bg-[#808080]"
              phx-click="increase_by_10"
            >
              +10 %
            </button>
            <button
              class="bg-[#ffffff] border border-2 border-[#000000] p-3 rounded-lg hover:bg-[#808080]"
              phx-click="decrease_by_10"
            >
              -10 %
            </button>
          </div>
        </div>
      </div>
    </div>
    """
  end

  # FUNCTIONS

  # on function for line 20
  def handle_event("on", _, lightStates) do
    IO.inspect(lightStates)
    lightStates = assign(lightStates, brightness: 100)
    {:noreply, lightStates}
  end

  # off function for line 22
  def handle_event("off", _, lightStates) do
    lightStates = assign(lightStates, brightness: 0)
    {:noreply, lightStates}
  end

  # increase by 10%
  def handle_event("increase_by_10", _, lightStates) do
    lightStates =
      update(lightStates, :brightness, fn currBrightness ->
        if currBrightness + 10 > 100 do
          currBrightness
        else
          currBrightness + 10
        end
      end)

    {:noreply, lightStates}
  end

  # increase by 10%
  def handle_event("decrease_by_10", _, lightStates) do
    lightStates =
      update(lightStates, :brightness, fn currBrightness ->
        if currBrightness - 10 < 0 do
          currBrightness
        else
          currBrightness - 10
        end
      end)

    {:noreply, lightStates}
  end

  def handle_event("changeColorToYellow", _, lightStates) do
    lightStates = assign(lightStates, lightColor: "#FFFF00")
    {:noreply, lightStates}
  end

  def handle_event("changeColorToPink", _, lightStates) do
    lightStates = assign(lightStates, lightColor: "#FFC0CB")
    {:noreply, lightStates}
  end

  def handle_event("changeColorToBlue", _, lightStates) do
    lightStates = assign(lightStates, lightColor: "#0000FF")
    {:noreply, lightStates}
  end

  def handle_event("changeColorToPurple", _, lightStates) do
    lightStates = assign(lightStates, lightColor: "#A020F0")
    {:noreply, lightStates}
  end
end
