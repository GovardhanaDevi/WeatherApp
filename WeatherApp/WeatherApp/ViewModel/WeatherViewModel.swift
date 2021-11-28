//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Govardhana Devi on 28/11/21.
//

import Foundation

protocol WeatherViewModelProtocol {
    var hourlyData: [Current]? { get }

    func getDailyData(for row: Int) -> Daily?
    func getNumOfRows(in section: Int) -> Int
    func getSectionTitle(for section: Int) -> String
    func getData(city: String, completionHandler: @escaping () -> Void)
}

class WeatherViewModel: WeatherViewModelProtocol {

    var dataSource: WeatherModel?

    var hourlyData: [Current]? {
        return dataSource?.hourly
    }

    func getDailyData(for row: Int) -> Daily? {
        return dataSource?.daily[row]
    }

    func getNumOfRows(in section: Int) -> Int {
        section == 0 ? 1 : 5
    }

    func getSectionTitle(for section: Int) -> String {
        section == 0 ? Constants.hoursSectionTitle : Constants.daysSectionTitle
    }

    func getData(city: String, completionHandler: @escaping () -> Void) {

        guard let (lat, long) = Utility.getCities()[city.uppercased()] else { return }

        APICaller.getWeather(latitude: lat, longitude: long) { weatherModel, error in
            self.dataSource = weatherModel
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }

}
