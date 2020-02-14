//
//  DataManager.swift
//  Project5
//
//  Created by Aaron Anderson on 2/13/20.
//  Copyright © 2020 Aaron Anderson. All rights reserved.
//

import Foundation

public class DataManager {
    
    var places: [Place] = []
    let defaults = UserDefaults.standard
    
    // MARK: - Singleton Stuff
    public static let sharedInstance = DataManager()
    
    fileprivate init() {}
    
    func loadAnnotationFromPlist() {
         if let path = Bundle.main.path(forResource: "Data", ofType: "plist") {
            let root = NSDictionary(contentsOfFile: path)
            let places = (root?.object(forKey: "places") as! NSArray)
            for place in places {
                let dict = place as! NSDictionary
                let newPlace = Place(name: dict["name"]! as! String, longDescription: dict["description"]! as! String, lat: dict["lat"]! as! Double, long: dict["long"]! as! Double)
                self.places.append(newPlace)
            }
         }
        
    }
    
    func saveFavorites(place: String ) {
        defaults.set(place, forKey: place)
    }
    
    func deleteFavorites(place: String) {
        defaults.removeObject(forKey: place)
    }
    
    func isFavorite(place: String) -> Bool {
        if (defaults.string(forKey: (place)) != nil) {
            return true
        }
        else {
            return false
        }
    }
    
    func getPlaceWithName(name: String) -> Place? {
        for place in places {
            if place.title!==name {
                return place
            }
        }
        return nil
    }
    
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
