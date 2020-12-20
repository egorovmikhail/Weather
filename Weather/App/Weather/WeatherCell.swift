//
//  WeatherCell.swift
//  Weather
//
//  Created by Михаил Егоров on 16.12.2020.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
  @IBOutlet weak var weather: UILabel!
  @IBOutlet weak var icon: UIImageView!
  @IBOutlet weak var time: UILabel!
  
  static let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "dd.MM.yyyy HH.mm"
    return df
  }()
  
  func configure(whithWeather weather: Weather) {
    let date = Date(timeIntervalSince1970: weather.date)
    let stringDate = WeatherCell.dateFormatter.string(from: date)
    
    self.weather.text = String(weather.temp)
    time.text = stringDate
    icon.image = UIImage(named: weather.weatherIcon)
  }
  
}
