//
//  ViewController.swift
//  Project5
//
//  Created by Aaron Anderson on 2/13/20.
//  Copyright © 2020 Aaron Anderson. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    // Outlets
    @IBOutlet weak var mapView: MKMapView! {
        didSet { mapView.delegate = self }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var favButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // present correctly
        definesPresentationContext = true
        // turn off compass and points of interest
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        // Add target for star button and make it yellow
        starButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        starButton.tintColor = UIColor.yellow
        // Semi-transparent location view
        locationView.alpha = 0.8
        // Layer the favorites button so it is dark and slightly curved
        favButton.layer.backgroundColor = UIColor.darkGray.cgColor
        favButton.layer.cornerRadius = 5
        // Load the annotations from plist
        DataManager.sharedInstance.loadAnnotationFromPlist()
        // Add the annotations to the mapview
        for place in DataManager.sharedInstance.places {
            mapView.addAnnotation(place)
        }
        // Start over wrigley field
        favoritePlace(name: "Wrigley Field")
        
    }
    
    // Star button action
    @objc func starButtonTapped(_ button: UIButton) {
        // Save the current place if it isn't selected
        if (!starButton.isSelected) {
            DataManager.sharedInstance.saveFavorites(place: titleLabel.text!)
        }
        // delete current place if it is selected
        else {
            DataManager.sharedInstance.deleteFavorites(place: titleLabel.text!)
        }
        // Select or de-select
        starButton.isSelected = !starButton.isSelected
        
    }
    
    
    // MARK: - Navigation

    // prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Using the correct identifier
        if segue.identifier == "segue" {
            // Set the PlacesFavoritesDelegate for the table view as this vc
            if let vc = segue.destination as? FavoritesViewController {
                vc.delegate = self
            }
        }
    }
    
    
}

///
/// MKMapView Delegate
///
extension MapViewController: MKMapViewDelegate {
    
    // Selected an annotation
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Set the title and subtitle
        titleLabel.text = (view.annotation?.title)!
        descLabel.text = (view.annotation?.subtitle)!
        // If it is a favorite set the star button to selected
        if (DataManager.sharedInstance.isFavorite(place: titleLabel.text!)) {
            starButton.isSelected = true
        }
        // Otherwise unselected
        else {
            starButton.isSelected = false
        }
    }
    
    // Set up views for annotations
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Make it a place
        if let annotation = annotation as? Place {
            let identifier = "CustomPin"
            
            // Create a new view
            var view: MKMarkerAnnotationView
            
            // Deque an annotation view or create a new one
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? PlaceMarkerView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = PlaceMarkerView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = false
            }
            // Return the view
            return (view as! PlaceMarkerView)
        }
        return nil
    }

}

///
/// PlacesFavorites Delegate
///
extension MapViewController: PlacesFavoritesDelegate {
    // Zooms to selected place and updates label
    func favoritePlace(name: String) {
        // Get the new place
        let newPlace = DataManager.sharedInstance.getPlaceWithName(name: name)
        // Set the zoom
        let viewRegion = MKCoordinateRegion(center: newPlace!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        // Set the region
        mapView.setRegion(viewRegion, animated: true)
        // Set the label text
        titleLabel.text = newPlace?.title
        descLabel.text = newPlace?.subtitle
        // Set the star button to filled or not filled
        if (DataManager.sharedInstance.isFavorite(place: titleLabel.text!)) {
            starButton.isSelected = true
        }
        else {
            starButton.isSelected = false
        }
    }

}

