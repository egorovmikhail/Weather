//
//  WeatherService.swift
//  Weather
//
//  Created by Михаил Егоров on 17.12.2020.
//

import Foundation
import Alamofire

class WeatherService {
  // базовый URL сервиса
  let baseUrl = "http://api.openweathermap.org"
  // ключ для доступа к сервису
  let apiKey = "8eb2bf7c277416368b75c686b2484892"
  
  // метод для загрузки данных, в качестве аргументов получает город
  func loadWeatherData(city: String, completion: @escaping ([Weather]) -> ()){
    
    // путь для получения погоды за 5 дней
    let path = "/data/2.5/forecast"
    // параметры, город, единицы измерения градусы, ключ для доступа к сервису
    let parameters: Parameters = [
      "q": city,
      "units": "metric",
      "appid": apiKey
    ]
    
    // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
    let url = baseUrl + path
    
    // делаем запрос
    
    
    
    AF.request(url, method: .get, parameters: parameters).responseData
    { repsonse in
      guard let data = repsonse.value else {return}
      let weather = try! JSONDecoder().decode(WeatherResponse.self, from: data).list
      completion(weather)
    }
    
  }
}

