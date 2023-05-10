defmodule LightAppWeb.DictionaryPage do
  use LightAppWeb, :live_view
  import HTTPoison

  def mount(_params, _session, socket) do
    {:ok, assign(socket, word: "", definition: "")}
  end

  def make_request(url) do
    IO.puts("Request URL: #{url}")

    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        # Parse the API response
        definition = parse_response(body)

        # Handle the successful response
        {:ok, definition}

      {:ok, %{status_code: status_code}} ->
        # Handle other successful status codes if needed
        IO.puts("Received status code: #{status_code}")
        {:error, "Request failed"}

      {:error, error} ->
        # Handle the request error
        IO.puts("Request error: #{inspect(error)}")
        {:error, "Request failed"}
    end
  end

  def parse_response(response) do
    case Jason.decode(response) do
      {:ok, data} ->
        case data do
          [%{"meanings" => meanings} | _] ->
            case List.first(meanings) do
              %{"definitions" => definitions} ->
                case List.first(definitions) do
                  %{"definition" => definition} -> definition
                  _ -> "No definition found"
                end

              _ ->
                "No definition found"
            end

          _ ->
            "No meanings found"
        end

      _ ->
        "No data received"
    end
  end

  def render(assigns) do
    word = assigns.word
    definition = assigns.definition

    ~H"""
    <p>What word do you want to learn more about?</p>
    <input
      class="border border-2 border-[#000000]"
      phx-debounce="500"
      phx-keyup="update_word"
      value={@word}
    />
    <button phx-click="request" phx-value-word={@word}>Submit</button>
    <p>
      <%= @definition %>
    </p>
    """
  end

  def handle_event("update_word", %{"value" => word}, socket) do
    {:noreply, assign(socket, word: word)}
  end

  def handle_event("request", %{"word" => word}, socket) do
    url = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    IO.puts("~~~~~~~~~~~~~~~ TESTING: #{url}#{word}")

    case make_request("#{url}#{word}") do
      {:ok, definition} ->
        {:noreply, assign(socket, definition: definition)}

      {:error, _} ->
        {:noreply, socket}
    end
  end
end
