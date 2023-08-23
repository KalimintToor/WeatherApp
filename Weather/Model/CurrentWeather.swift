//
//  CurrentWeather.swift
//  Weaher
//
//  Created by Александр on 7/24/23.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    
    let temperature: Double?
    var temperatureString: String {
        return String(format: "%.0f", temperature ?? 0.0)
    }
    
    let feelsLikeTemperature: Double?
    var feelsLikeTemperatureString: String {
        return String(format: "%.0f", feelsLikeTemperature ?? 0.0)
    }
    
    var conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
    
    init(cityName: String, conditionCode: Int, temperature: Double, feelsLikeTemperature: Double) {
        self.cityName = cityName
        self.conditionCode = conditionCode
        self.temperature = temperature
        self.feelsLikeTemperature = feelsLikeTemperature
    }
}

