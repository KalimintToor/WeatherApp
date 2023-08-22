//
//  CurrentWeatherData.swift
//  Weaher
//
//  Created by Александр on 7/24/23.
//

import Foundation

let apiKey = "358389cc2e7b7f987ac85f1075b911c6"

struct CurrentWeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable{
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
}
