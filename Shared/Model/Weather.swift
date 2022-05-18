//
//  Weather.swift
//  OWeatherApp (iOS)
//
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let id: Int
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let name: String
    let cod: Int
}

extension WeatherResponse {
    var firstWeatherIcon: String {
        weather.first?.icon ?? ""
    }
    var cityDescription: String {
        "\(name) (\(sys.country))"
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}


// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}


// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

extension Main {
    var temperature: String {
        "\(String(format: "%.2f", arguments: [temp]))°"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: TimeInterval
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}


// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}



// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    let cod: String
    let message, cnt: Int
    let list: [ForecastList]
    let city: City
}

extension ForecastResponse {
    var filteredList: [ForecastList] {
        var newList: [ForecastList] = []
        for day in list {
            if newList.last?.date.getHumanReadableDayString() != day.date.getHumanReadableDayString() {
                newList.append(day)
            }
        }
        return newList
    }
    var cityDescription: String {
        "\(city.name) (\(city.country))"
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: ForecastCoord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct ForecastCoord: Codable {
    let lat, lon: Double
}

// MARK: - List
struct ForecastList: Codable {
    let dt: TimeInterval
    let main: ForecastMain
    let weather: [ForecastWeather]
    let clouds: ForecastClouds
    let wind: ForecastWind
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let sys: ForecastSys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

extension ForecastList {
    var date: Date {
        Date(timeIntervalSince1970: self.dt)
    }
}

// MARK: - Clouds
struct ForecastClouds: Codable {
    let all: Int
}

// MARK: - Main
struct ForecastMain: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

extension ForecastMain {
    var temperature: String {
        "\(String(format: "%.0f", arguments: [temp]))°"
    }
    
    var min: String {
        "\(String(format: "%.0f", arguments: [tempMin]))°"
    }
    
    var max: String {
        "\(String(format: "%.0f", arguments: [tempMax]))°"
    }
}


// MARK: - Rain
struct Rain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct ForecastSys: Codable {
    let pod: String
}

// MARK: - Weather
struct ForecastWeather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct ForecastWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
