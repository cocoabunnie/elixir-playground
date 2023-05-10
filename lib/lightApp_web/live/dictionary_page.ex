defmodule LightAppWeb.DictionaryPage do
  use LightAppWeb, :live_view
  use HTTPoison.Base

  def mount(_params, _session, dictionaryStates) do
    IO.inspect(dictionaryStates)
    {:ok, assign(dictionaryStates, word: "ant", definition: "Definition here")}
  end

  def get_owl_definition(word) do
    case HTTPoison.get("https://api.dictionaryapi.dev/api/v2/entries/en/#{word}") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts(body)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def render(assigns) do
    ~H"""
    <p>What word do you want to learn more about??</p>
    <input class="border border-2 border-[#000000]" value={@word} />
    <button phx-click="getDefinition">Submit</button>
    """
  end

  def handle_event("getDefinition", %{"word" => word}, dictionaryStates) do
    get_owl_definition(word)
    {:noreply, dictionaryStates}
  end
end
