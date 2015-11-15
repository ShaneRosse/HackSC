//
//  Assassin.swift
//  ParseStarterProject-Swift
//
//  Created by Shane Rosse on 11/14/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation
import Parse
import MapKit


class Assassin: NSObject, MKAnnotation {
    let name: String?
    var geoPoint: PFGeoPoint
    var coordinate: CLLocationCoordinate2D
    var points: Int
    
    init(name: String?, coordinate: CLLocationCoordinate2D) {
        
        self.name = name
        self.points=0
        self.coordinate=coordinate
        self.geoPoint = PFGeoPoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
        super.init()
    }
    
    func distanceFrom(other: Assassin)->CLLocationDistance{
        let deltaLatitude=self.geoPoint.latitude-other.geoPoint.latitude
        let deltaLongitude=self.geoPoint.longitude-other.geoPoint.longitude
        let distance=sqrt(pow(deltaLatitude,2)+pow(deltaLongitude,2))
        return distance
    }
    
    func setLocation(coor: CLLocationCoordinate2D){
        self.coordinate=coor
        self.geoPoint=PFGeoPoint(latitude: coor.latitude, longitude: coor.longitude)
    }
}