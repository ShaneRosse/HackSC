//
//  Assassin.swift
//  ParseStarterProject-Swift
//
//  Created by Shane Rosse on 11/14/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation
import MapKit

class Assassin: NSObject, MKAnnotation {
    let name: String?
    var coordinate: CLLocationCoordinate2D
    var points: Int
    
    init(name: String?, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.coordinate = coordinate
        self.points=0
        super.init()
    }
    
    func distanceFrom(other: Assassin)->CLLocationDistance{
        let deltaLatitude=self.coordinate.latitude-other.coordinate.latitude
        let deltaLongitude=self.coordinate.longitude-other.coordinate.longitude
        let distance=sqrt(pow(deltaLatitude,2)+pow(deltaLongitude,2))
        return distance
    }
    
}