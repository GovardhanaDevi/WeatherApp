//
//  DaysTableViewCell.swift
//  WeatherApp
//
//  Created by Govardhana Devi on 28/11/21.
//

import UIKit

class DaysTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "DaysTableViewCell"
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 12
    }

    static func registerNib() -> UINib {
        return UINib(nibName: DaysTableViewCell.reuseIdentifier, bundle: nil)
    }

    func configure(with data: Daily) {
        weatherImageView.setImage(with: data.weather.first?.icon ?? "")
        dateLabel.text = data.dt.day
        infoLabel.text = data.weather.first?.description
        temperatureLabel.text = getTempString(max: data.temp.max,
                                              min: data.temp.min)
        setCorners()
    }

    func getTempString(max: Double, min: Double) -> String {
        let maxTemp = max.inCelcius
        let minTemp = min.inCelcius
        return "\(maxTemp)°  \(minTemp)°"
    }

    func setCorners() {
        if tag == 0 {
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if tag == 4 {
            contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            contentView.layer.maskedCorners = []
        }
    }
}
