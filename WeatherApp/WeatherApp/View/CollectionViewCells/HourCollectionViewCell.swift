//
//  HourCollectionViewCell.swift
//  WeatherApp
//
//  Created by Govardhana Devi on 28/11/21.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "HourCollectionViewCell"
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var hourLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static func registerNib() -> UINib {
        return UINib(nibName: HourCollectionViewCell.reuseIdentifier, bundle: nil)
    }

    func configure(with data: Current) {
        weatherImageView.setImage(with: data.weather.first?.icon ?? "")
        hourLabel.text = data.dt.time
        humidityLabel.text = "\(data.humidity)%"
        let temp = data.temp.inCelcius
        temperatureLabel.text = "\(temp)°"
    }
    
}

