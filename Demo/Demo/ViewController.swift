//
//  ViewController.swift
//  Demo
//
//  Created by Eugene Trapeznikov on 9/13/18.
//  Copyright © 2018 trapeznikov. All rights reserved.
//

import UIKit

class ViewController: ETCollapsableTable, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  // Uncommnet for multiple selection
//  override func singleOpenSelectionOnly() -> Bool {
//    return false
//  }

  override func buildItems() -> [ETCollapsableTableItem] {
    var items = [ETCollapsableTableItem]()
    
    let moviesMusicGames = ETCollapsableTableItem(title: "Movies, Music & Games")
    
    let moviesAndTv = ETCollapsableTableItem(title: "Movies and TV")
    let bluRay = ETCollapsableTableItem(title: "Blu-ray")
    let cdVinyl = ETCollapsableTableItem(title: "CDs & Vinyl")
    let videoGames = ETCollapsableTableItem(title: "Video & Games")
    
    moviesMusicGames.items = [moviesAndTv, bluRay, cdVinyl, videoGames]
    
    items.append(moviesMusicGames)
    
    let beatyAndHealth = ETCollapsableTableItem(title: "Beauty and Health")
    
    items.append(beatyAndHealth)
    
    let sportsAndOutdoors = ETCollapsableTableItem(title: "Sports & Outdoors")
    
    let athleticClothing = ETCollapsableTableItem(title: "Athletic Clothing")
    let exercise = ETCollapsableTableItem(title: "Exercise & Fitness")
    let hunting = ETCollapsableTableItem(title: "Hunting & Fishing")
    let fanShop = ETCollapsableTableItem(title: "Fan Shop")
    let golf = ETCollapsableTableItem(title: "Golf")
    
    sportsAndOutdoors.items = [athleticClothing, exercise, hunting, fanShop, golf]
    
    items.append(sportsAndOutdoors)
    
    return items
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.numberOfSections()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.numberOfRowsInSection(section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let item = self.itemAtIndexPath(indexPath)
    
    let isRootItem = indexPath.row == 0
    
    cell.textLabel?.text = (isRootItem ? "" : "      ") + item.title
    
    if item.items.count > 0 {
      if item.isOpen {
        cell.accessoryView = UIImageView(image: UIImage(named: "up-arrow"))
      } else {
        cell.accessoryView = UIImageView(image: UIImage(named: "down-arrow"))
      }
    } else {
      cell.accessoryView = nil
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
    let item = self.itemAtIndexPath(indexPath)
    if item.items.count > 0 {
      tableView.reloadRows(at: [indexPath], with: .none)
    }
  }

}

