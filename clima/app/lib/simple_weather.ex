defmodule App.SimpleWeather do

    def start(cities) do
        cities #-> Recebe uma lista de cidades
        |> Enum.map(&create_task/1) #-> Cria uma Task para cada uma delas
        |> Enum.map(&Task.await/1) #-> Processa a resposta de cada Task
    end

    defp create_task(city) do
        #-> Cria uma Task com a temperatura da cidade informada 
        Task.async(fn -> temperature_of(city) end)
    end

    #-> Restante do código permanece o mesmo

    def get_temperature() do
        # Recebe o PID do manager e a cidade.

        # Envia uma mensagem de volta ao manager com a temperatura da c idade.

        # O coringa entende qualquer outra coias como um erro.

        # Chama get_temperature() no final para o processo continuar vivo e esperando por mensagens.
        receive do
            {manager_pid, location} ->
                send(manager_pid, {:ok, temperature_of(location)})
                _ ->
                 IO.puts "Error"
        end
        get_temperature()
    end

    def manager(cities \\ [], total) do
        # Se o manager recer a temperatura e :ok a mantém em uma list a (que foi inicializada como vazia no início).

        # Se o total da lista for igual ao total de cidades avisa a si mesmo para parar o processo com :exit.
        # Se receber :exit ele executa a si mesmo uma última vez para processar o resultado.
        # Ao receber o atom :exit para o processo, ordena o resultado e o mostra na tela.

        # Caso não receba :exit executa a si mesmo de maneira recursiva passando a nova lista e o total.

        # O coringa no final execulta a si mesmo com os mesmos argumentos em caso de erro.
        receive do
            {:ok, temp} ->
                results = [ temp | cities]
                if(Enum.count(results) == total) do
                    send self(), :exit
                end
                manager(results, total)
                :exit ->
                    IO.puts(cities |> Enum.sort |> Enum.join(", "))
                    _ ->
                    manager(cities, total)
        end
    end

    def get_appid() do
        "dd26d77bcd20dc76a25e769f7328ca8b"
    end

    def get_endpoint(location) do
        location = URI.encode(location)
        "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{get_appid()}"
    end

    def kelvin_to_celsius(kelvin) do
        (kelvin - 273.15 |> Float.round(1))
    end

    def temperature_of(location) do
        result = get_endpoint(location) |> HTTPoison.get |> parser_response
        case result do
            {:ok, temp} ->
                "#{location}: #{temp} C"
            :error -> 
                "#{location} not found"
        end
    end

    defp parser_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
        body |> JSON.decode! |> compute_temperature
    end

    defp parser_response(_), do: :error

    defp compute_temperature(json) do
        try do
            temp = json["main"]["temp"] |> kelvin_to_celsius
            {:ok, temp}
            rescue
                _ -> :error
        end
    end    
end