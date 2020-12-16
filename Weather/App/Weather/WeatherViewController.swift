//
//  WeatherViewController.swift
//  Weather
//
//  Created by Михаил Егоров on 16.12.2020.
//

import UIKit

class WeatherViewController: UIViewController {
  
  let weatherService = WeatherService()
  
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.dataSource = self
      collectionView.delegate = self
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    weatherService.loadWeatherData(city: "Moscow")
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

extension WeatherViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
    cell.weather.text = "30 C"
    cell.time.text = "30.08.2017 18:00"
    return cell
  }
  
}

extension WeatherViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
}
