//
//  Place.swift
//  Project5
//
//  Created by Aaron Anderson on 2/13/20.
//  Copyright © 2020 Aaron Anderson. All rights reserved.
//

import UIKit
import MapKit

// extends MKPointAnnotations
class Place: MKPointAnnotation {
    
    // Constructor based on info from plist
    init(name: String, longDescription: String, lat: Double, long: Double) {
        super.init()
        self.title = name
        self.subtitle = longDescription
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }

}
