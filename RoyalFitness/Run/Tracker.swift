//
//  Tracker.swift
//  exergame2
//
//  Created by Lyndbergh Simelus on 3/14/20.
//  Copyright © 2020 Lyndbergh Simelus. All rights reserved.
//

import Foundation
import CoreLocation

class Tracker {

    var data = [CLLocation]()
    var totalDistance = 0.01
    var prev:CLLocation?
    
    
    func add (_ new: CLLocation) -> Double{//adds the difference of coordinate from last location to current location
        var length = 0.0
        data.append(new)
        if (prev != nil){//if it is not the first CCLocation
            length = new.distance(from: prev!)
            length = Double(round(length))
            totalDistance += length
        }else{
            prev = new
            return 0.01
        }
        prev = new
        if totalDistance < 0.01 {
            return 0.01
        }
        return totalDistance/1609.0
    }
}
