defmodule App.Weather do
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
end