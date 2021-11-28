//
//  APICaller.swift
//  WeatherApp
//
//  Created by Govardhana Devi on 28/11/21.
//

import Foundation

enum CustomError {
    case invalidURL
    case emptyData
    case serverError(String)
}

class APICaller {
    static let apiKey = "2a9a0070660b017f7c6aa9040bf6061a"
    static func getWeather(latitude: String, longitude: String,
                    completionHandler: @escaping (WeatherModel?, CustomError?) -> Void) {

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&APPID=\(APICaller.apiKey)") else {
            completionHandler(nil, .invalidURL)
            return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completionHandler(nil, .serverError(error.localizedDescription))
                } else {
                    completionHandler(nil, .emptyData)
                }
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .secondsSince1970
                let weatherModel = try jsonDecoder.decode(WeatherModel.self, from: data)
                
                completionHandler(weatherModel, nil)
            } catch {
                completionHandler(nil, .emptyData)
            }
        }
        task.resume()
    }
}
