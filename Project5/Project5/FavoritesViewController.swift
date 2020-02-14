//
//  FavoritesViewController.swift
//  Project5
//
//  Created by Aaron Anderson on 2/13/20.
//  Copyright © 2020 Aaron Anderson. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: PlacesFavoritesDelegate?
    @IBOutlet weak var tableView: UITableView!
    var favorites: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.delegate = MapViewController
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favorites = DataManager.sharedInstance.getFavorites()
        tableView.rowHeight = 80
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") {
            if let label = cell.textLabel {
                label.text = favorites[indexPath.row].title
            }
            if let subtitle = cell.detailTextLabel {
                subtitle.text = favorites[indexPath.row].subtitle
            }
            // Return cell.
            return cell
        }
        // Return empty cell.
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // 1 section
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //return DataManager.sharedInstance.defaults.size()
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//                // Set it to an IssueTableViewCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FavoriteTableViewCell
//
//        // Set the title
//        cell.title.text = DataManager.sharedInstance.places[indexPath.row].title
//        // Set the user to be @ + the user's login
//        cell.longDescription.text = DataManager.sharedInstance.places[indexPath.row].subtitle
//        // return the cell
//        return cell
//    }
//
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

