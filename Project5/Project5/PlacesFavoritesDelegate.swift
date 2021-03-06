//
//  PlacesFavoritesDelegate.swift
//  Project5
//
//  Created by Aaron Anderson on 2/13/20.
//  Copyright © 2020 Aaron Anderson. All rights reserved.
//

import Foundation

// For communicating between vc's
protocol PlacesFavoritesDelegate: class {
    func favoritePlace(name: String) -> Void
}
