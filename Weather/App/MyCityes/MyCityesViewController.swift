//
//  MyCityesViewController.swift
//  Weather
//
//  Created by Михаил Егоров on 16.12.2020.
//

import UIKit

class MyCityesViewController: UIViewController {
  
  @IBOutlet weak var tableViev: UITableView! {
    didSet {
      tableViev.dataSource = self
      tableViev.delegate = self
    }
  }
  
  var cities = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @IBAction func addCity(segue: UIStoryboardSegue) {
    if segue.identifier == "addCity"{
      guard let allCitiesController = segue.source as? AllCityesViewController else {return}
      if let indexPath = allCitiesController.tableView.indexPathForSelectedRow{
        let city = allCitiesController.cities[indexPath.row]
        if !cities.contains(city){
          cities.append(city)
          tableViev.reloadData()
        }
      }
    }
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

extension MyCityesViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cities.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableViev.dequeueReusableCell(withIdentifier: "MyCityesCell", for: indexPath) as! MyCityesCell
    cell.cityName.text = cities[indexPath.row]
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete{
      cities.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
}

extension MyCityesViewController: UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("нажата строка № \(indexPath.row) в секции \(indexPath.section)")
  }
}



