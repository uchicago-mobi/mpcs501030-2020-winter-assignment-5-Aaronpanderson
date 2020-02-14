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
        definesPresentationContext = true
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        let meters: Double =  8000
        let zoomLocation = CLLocationCoordinate2DMake(41.8781, -87.6298)
        let viewRegion = MKCoordinateRegion(center: zoomLocation, latitudinalMeters: meters, longitudinalMeters: meters)
        mapView.setRegion(viewRegion, animated: true)
        starButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        favButton.addTarget(self, action: #selector(favButtonTapped(_:)), for: .touchUpInside)
        starButton.tintColor = UIColor.yellow
        locationView.alpha = 0.8
        favButton.layer.backgroundColor = UIColor.darkGray.cgColor
        favButton.layer.cornerRadius = 5
        DataManager.sharedInstance.loadAnnotationFromPlist()
        for place in DataManager.sharedInstance.places {
            mapView.addAnnotation(place)
        }
        
    }
    
    
    @objc func starButtonTapped(_ button: UIButton) {
        if (!starButton.isSelected) {
            DataManager.sharedInstance.saveFavorites(place: titleLabel.text!)
        }
        else {
            DataManager.sharedInstance.deleteFavorites(place: titleLabel.text!)
        }
        starButton.isSelected = !starButton.isSelected
        
    }
    
    @objc func favButtonTapped(_ button: UIButton) {
//        let vc = FavoritesViewController()
//        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
}

///
/// MKMapView Delegate
///
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        titleLabel.text = (view.annotation?.title)!
        descLabel.text = (view.annotation?.subtitle)!
        if (DataManager.sharedInstance.isFavorite(place: titleLabel.text!)) {
            starButton.isSelected = true
        }
        else {
            starButton.isSelected = false
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
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
            return (view as! PlaceMarkerView)
        }
        return nil
    }

}

///
/// PlacesFavorites Delegate
///
extension MapViewController: PlacesFavoritesDelegate {
    func favoritePlace(name: String) {
        let newPlace = DataManager.sharedInstance.getPlaceWithName(name: name)
        let viewRegion = MKCoordinateRegion(center: newPlace!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(viewRegion, animated: true)
    }

}

// MARK: - Navigation

//// prepare for segue
//func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    // Using the correct identifier
//    if segue.identifier == "segue" {
//        // Set up the new IssueDetailViewController
//        if let vc = segue.destination as? FavoritesViewController {
//            // Stuff
//        }
//    }
//}
