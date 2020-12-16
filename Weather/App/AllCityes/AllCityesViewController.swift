//
//  AllCityesViewController.swift
//  Weather
//
//  Created by Михаил Егоров on 16.12.2020.
//

import UIKit

class AllCityesViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!{
    didSet{
      tableView.dataSource = self
    }
  }
  
  var cities = [
          "Moscow",
          "Krasnoyarsk",
          "London",
          "Paris"
      ]

  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension AllCityesViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cities.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AllCityesCell", for: indexPath) as! AllCityesCell
    cell.cityName.text = cities[indexPath.row]
    
    return cell
  }
    
}
