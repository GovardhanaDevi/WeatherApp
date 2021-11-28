//
//  APICaller.swift
//  WeatherApp
//
//  Created by Govardhana Devi on 28/11/21.
//

import Foundation

class APICaller {
    static func getWeather(latitude: String, longitude: String,
                    completionHandler: @escaping (WeatherModel?, String?) -> Void) {

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&APPID=2a9a0070660b017f7c6aa9040bf6061a") else {
            completionHandler(nil, "invalidURL")
            return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completionHandler(nil, error.localizedDescription)
                } else {
                    completionHandler(nil, "Empty Data")
                }
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .secondsSince1970
                let weatherModel = try jsonDecoder.decode(WeatherModel.self, from: data)
                
                completionHandler(weatherModel, nil)
            } catch {
                completionHandler(nil, "Empty Data")
            }
        }
        task.resume()
    }
}
