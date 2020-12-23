//
//  WeatherViewController.swift
//  Weather
//
//  Created by Михаил Егоров on 16.12.2020.
//

import UIKit
import RealmSwift

class WeatherViewController: UIViewController {
  //  MARK: - UICollectionView
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.dataSource = self
      collectionView.delegate = self
    }
  }
  
  //  MARK: - PROPERTIES
  let weatherService = WeatherService()
  var token: NotificationToken?
  var cityName = ""
  var weathers: List<Weather>!
  
  //  MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    weatherService.loadWeatherData(city: cityName)
    pairTableAndRealm()
  }
  
  //  MARK: - pairTableAndRealm
  func pairTableAndRealm() {
    guard let realm = try? Realm(), let city = realm.object(ofType: City.self, forPrimaryKey: cityName) else { return }
    
    weathers = city.weathers
    
    token = weathers.observe { [weak self] (changes: RealmCollectionChange) in
      guard let collectionView = self?.collectionView else { return }
      switch changes {
        case .initial:
          collectionView.reloadData()
        case .update(_, let deletions, let insertions, let modifications):
          collectionView.performBatchUpdates({
            collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
            collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
            collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
          }, completion: nil)
        case .error(let error):
          fatalError("\(error)")
      }
    }
  }
} //  : - viewController

//  MARK: - UICollectionViewDataSource
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

//  MARK: - UICollectionViewDelegate
extension WeatherViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
}
