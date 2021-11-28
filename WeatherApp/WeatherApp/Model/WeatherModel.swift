//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Govardhana Devi on 28/11/21.
//

import Foundation
// MARK: - WeatherModel
struct WeatherModel: Decodable {
    let hourly: [Current]
    let daily: [Daily]
}

// MARK: - Current
struct Current: Decodable {
    let dt: Date
    let temp: Double
    let humidity: Int
    let weather: [Weather]
}

// MARK: - Daily
struct Daily: Decodable {
    let dt: Date
    let temp: Temp
    let humidity: Int
    let weather: [Weather]
}


// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let description: String
    let icon: String
}

