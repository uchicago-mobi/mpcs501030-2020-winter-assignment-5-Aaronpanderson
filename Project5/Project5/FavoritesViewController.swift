//
//  FavoritesViewController.swift
//  Project5
//
//  Created by Aaron Anderson on 2/13/20.
//  Copyright © 2020 Aaron Anderson. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Delegate
    weak var delegate: PlacesFavoritesDelegate?
    // Favorite places
    var favorites: [Place] = []
    // outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var xButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
        // Add target for X (back) button
        xButton.addTarget(self, action: #selector(xButtonTapped(_:)), for: .touchUpInside)
    }
    
    // Update data when viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // get the favorites from the datamanager
        favorites = DataManager.sharedInstance.getFavorites()
        // Set the rowHeight
        tableView.rowHeight = 80
        // Reload the data
        tableView.reloadData()
    }
    
    // X button tapped, dismiss this vc
    @objc func xButtonTapped(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Set up the table cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // set the Cell as a reusable cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") {
            // Set the title
            if let label = cell.textLabel {
                label.text = favorites[indexPath.row].title
            }
            // Set the subtitle
            if let subtitle = cell.detailTextLabel {
                subtitle.text = favorites[indexPath.row].subtitle
            }
            // Return cell.
            return cell
        }
        // Return empty cell.
        return UITableViewCell()
    }

    // Number of rows is number of favorites
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    // When selected we pass the information back to the delegate and dismiss
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.favoritePlace(name: favorites[indexPath.row].title!)
        self.dismiss(animated: true, completion: nil)
    }
    
}
