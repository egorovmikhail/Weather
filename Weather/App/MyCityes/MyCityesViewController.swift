//
//  MyCityesViewController.swift
//  Weather
//
//  Created by Михаил Егоров on 16.12.2020.
//

import UIKit
import RealmSwift

class MyCityesViewController: UIViewController {
  
  
//  MARK: - UITableView
  @IBOutlet weak var tableViev: UITableView! {
    didSet {
      tableViev.dataSource = self
      tableViev.delegate = self
    }
  }
//  MARK: - PROPERTIES
  var cityes: Results<City>?
  var token: NotificationToken?
//  var cities = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pairTableAndRealm()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toWeatherViewController", let cell = sender as? MyCityesCell {
      let ctrl = segue.destination as! WeatherViewController
      if let indexPath = tableViev.indexPath(for: cell) {
        ctrl.cityName = cityes![indexPath.row].name
      }
    }
  }
  
  //  MARK: - addButtonPressed
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    showAddCityForm()
  }
  
  //  MARK: - addCity
  func addCity(name: String) {
    let newCity = City()
    newCity.name = name
    do {
      let realm = try Realm()
      realm.beginWrite()
      realm.add(newCity, update: .modified)
      try realm.commitWrite()
    } catch {
      print(error)
    }
  }
    
  //  MARK: - showAddCityForm
  func showAddCityForm() {
    let alertController = UIAlertController(title: "Введите город", message: nil, preferredStyle: .alert)
    alertController.addTextField{(_ textField: UITextField) -> Void in
    }
    let confirmAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] action in
      guard let name = alertController.textFields?[0].text else { return }
      self?.addCity(name: name)
    }
    alertController.addAction(confirmAction)
    let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    present(alertController, animated: true)
  }
    
  //  MARK: - pairTableAndRealm
  func pairTableAndRealm() {
    guard let realm = try? Realm() else { return }
    cityes = realm.objects(City.self)
    token = cityes?.observe{[weak self] (changes: RealmCollectionChange) in
      guard let tableView = self?.tableViev else { return }
      switch changes {
        case .initial:
          tableView.reloadData()
        case .update(_, let deletions, let insertions, let modifications):
          tableView.beginUpdates()
          tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                               with: .automatic)
          tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                               with: .automatic)
          tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                               with: .automatic)
          tableView.endUpdates()
        case .error(let error):
          fatalError("\(error)")
      }
    }
  }
  
}//MARK: - controller



  //  MARK: - UITableViewDataSource

extension MyCityesViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cityes?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableViev.dequeueReusableCell(withIdentifier: "MyCityesCell", for: indexPath) as! MyCityesCell
    cell.cityName.text = cityes?[indexPath.row].name
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    let city = cityes?[indexPath.row]
    if editingStyle == .delete {
      do {
        let realm = try Realm()
        realm.beginWrite()
        realm.delete(city!.weathers)
        realm.delete(city!)
        try realm.commitWrite()
      } catch {
        print(error)
      }
    }
  }
  
}

//  MARK: - UITableViewDelegate

extension MyCityesViewController: UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("нажата строка № \(indexPath.row) в секции \(indexPath.section)")
  }
}



