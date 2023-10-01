import requests

# OpenWeatherMap API endpoint
api_url = "https://samples.openweathermap.org/data/2.5/forecast/hourly?q=London,us&appid=b6907d289e10d714a6e88b30761fae22"

# Function to fetch weather data from the API
def fetch_weather_data():
    response = requests.get(api_url)
    data = response.json()
    return data

# Function to get temperature
def get_temperature(data, date_time):
    for item in data["list"]:
        if item["dt_txt"] == date_time:
            return item["main"]["temp"]
    return None

# Function to get wind speed
def get_wind_speed(data, date_time):
    for item in data["list"]:
        if item["dt_txt"] == date_time:
            return item["wind"]["speed"]
    return None

# Function to get pressure
def get_pressure(data, date_time):
    for item in data["list"]:
        if item["dt_txt"] == date_time:
            return item["main"]["pressure"]
    return None

# Main program
if __name__ == "__main__":
    weather_data = fetch_weather_data()

    while True:
        print("\nOptions:")
        print("1. Get Temperature")
        print("2. Get Wind Speed")
        print("3. Get Pressure")
        print("0. Exit")

        choice = input("Enter your choice: ")

        if choice == "1":
            date_time = input("Enter the date and time (yyyy-mm-dd hh:mm:ss): ")
            temperature = get_temperature(weather_data, date_time)
            if temperature is not None:
                print(f"Temperature at {date_time}: {temperature}°C")
            else:
                print("Data not found for the given date and time.")

        elif choice == "2":
            date_time = input("Enter the date and time (yyyy-mm-dd hh:mm:ss): ")
            wind_speed = get_wind_speed(weather_data, date_time)
            if wind_speed is not None:
                print(f"Wind Speed at {date_time}: {wind_speed} m/s")
            else:
                print("Data not found for the given date and time.")

        elif choice == "3":
            date_time = input("Enter the date and time (yyyy-mm-dd hh:mm:ss): ")
            pressure = get_pressure(weather_data, date_time)
            if pressure is not None:
                print(f"Pressure at {date_time}: {pressure} hPa")
            else:
                print("Data not found for the given date and time.")

        elif choice == "0":
            break

        else:
            print("Invalid choice. Please enter a valid option.")
