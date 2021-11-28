//
//  Utility.swift
//  WeatherApp
//
//  Created by Govardhana Devi on 28/11/21.
//

import Foundation

class Utility {
    static func getCities() -> [String: (String, String)] {

        var dataArray = [String: (String, String)]()
        if let path = Bundle.main.path(forResource: "cities_20000", ofType: "csv") {
            
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                let dataEncoded = String(data: data, encoding: .utf8)
                if  let dataArr = dataEncoded?.components(separatedBy: "\n").map({ $0.components(separatedBy: ",") }) {
                    
                    for line in dataArr {
                        if line.count > 5 {
                            dataArray[line[1].uppercased()] = (line[5], line[6])
                        }
                    }
                    return dataArray
                }
            } catch let jsonErr {
                print("\n Error reading CSV file: \n ", jsonErr)
            }
        }
        return dataArray
    }
}
