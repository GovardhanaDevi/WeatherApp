//
//  Extensions.swift
//  WeatherApp
//
//  Created by Govardhana Devi on 28/11/21.
//

import UIKit

extension Double {
    var inCelcius: Int {
        return Int(self - 273.15)
    }
}

extension Date {
    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: self)
    }

    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d"
        return dateFormatter.string(from: self)
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func setImage(with iconName: String) {
        guard let url = URL(string: "http://openweathermap.org/img/wn/\(iconName)@2x.png") else {return}
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }

        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: data) else { return }
                self.image = imageToCache
                imageCache.setObject(imageToCache, forKey: url as AnyObject)
            }
        }
        
    }
}

