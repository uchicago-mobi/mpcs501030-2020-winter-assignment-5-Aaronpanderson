//
//  DataManager.swift
//  Project5
//
//  Created by Aaron Anderson on 2/13/20.
//  Copyright © 2020 Aaron Anderson. All rights reserved.
//

import Foundation

public class DataManager {
    
    // Holds all the places
    var places: [Place] = []
    // User defaults
    let defaults = UserDefaults.standard
    
    // MARK: - Singleton Stuff
    public static let sharedInstance = DataManager()
    
    fileprivate init() {}
    
    // Get the places from plist
    func loadAnnotationFromPlist() {
        // Get the path
        if let path = Bundle.main.path(forResource: "Data", ofType: "plist") {
            // Root
            let root = NSDictionary(contentsOfFile: path)
            // Get places array from root
            let places = (root?.object(forKey: "places") as! NSArray)
            // Get the individual places
            for place in places {
                // Place is a dictionary
                let dict = place as! NSDictionary
                // Set up the places based on the dictionary
                let newPlace = Place(name: dict["name"]! as! String, longDescription: dict["description"]! as! String, lat: dict["lat"]! as! Double, long: dict["long"]! as! Double)
                // Add the place to the places array
                self.places.append(newPlace)
            }
         }
        
    }
    
    // Save a favorite place
    func saveFavorites(place: String ) {
        defaults.set(place, forKey: place)
    }
    
    // Remove a favorite place
    func deleteFavorites(place: String) {
        defaults.removeObject(forKey: place)
    }
    
    // Check if a place is a favorite
    func isFavorite(place: String) -> Bool {
        if (defaults.string(forKey: (place)) != nil) {
            return true
        }
        else {
            return false
        }
    }
    
    // Return a place with a given name
    func getPlaceWithName(name: String) -> Place? {
        for place in places {
            if place.title!==name {
                return place
            }
        }
        return nil
    }
    
    // Get all of the favorite places
    func getFavorites() -> [Place] {
        var favorites: [Place] = []
        for place in places {
            if isFavorite(place: place.title!) {
                favorites.append(place)
            }
        }
        return favorites
    }
    
}
