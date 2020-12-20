//
//  WeatherViewController.swift
//  Weather
//
//  Created by Михаил Егоров on 16.12.2020.
//

import UIKit
import RealmSwift

class WeatherViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.dataSource = self
      collectionView.delegate = self
    }
  }
  
  let weatherService = WeatherService()
  var weathers = [Weather]()
  
//  MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    weatherService.loadWeatherData(city: "Moscow") { [weak self]  in
      self?.loadData()
      self?.collectionView.reloadData()
    }
  }
  
  func loadData() {
    do {
      let realm = try Realm()
      let weathers = realm.objects(Weather.self).filter("city == %@", "Moscow")
      self.weathers = Array(weathers)
    } catch {
      print(error)
    }
  }
  
}

extension WeatherViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return weathers.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
    cell.configure(whithWeather: weathers[indexPath.row])
    return cell
  }
  
}

extension WeatherViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
}
