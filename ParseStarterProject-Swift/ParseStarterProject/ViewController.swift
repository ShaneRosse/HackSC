/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {
    let regionRadius: CLLocationDistance = 1000
    var players = [Assassin]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func MoveUp(sender: UIButton) {
        players[0].coordinate.latitude+=0.001
        let long=players[0].coordinate.longitude
        let lat=players[0].coordinate.latitude
        centerMapOnLocation(CLLocation(latitude: lat ,longitude: long))
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // this code needs to be moved into CoreLocation location updates area
        // Corresponds to Los Angeles
        // TODO dynamically set lat long to current coordinate
        mapView.delegate = self
//        
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            print("Object has been saved.")
//        }
//        
        
        
        var myAssassin: Assassin?
        if let userloc = mapView.userLocation.location{
            myAssassin = Assassin(name: "User", coordinate: userloc.coordinate)
        }
        
        
        let assassin2 = Assassin(name: "King David Kalakaua", coordinate: CLLocationCoordinate2D(latitude: 34.055, longitude: -118.204))
        
        
        if myAssassin != nil{
            players.append(myAssassin!);
        }
        else{
            print("no myAssassin")
        }
        
        
        players.append(assassin2);
        
        
        let initialLocation = CLLocation(latitude: players[0].coordinate.latitude ,longitude: players[0].coordinate.longitude)
        
        for assassins in players{
            print("added")
            mapView.addAnnotation(assassins)
        }
        
        centerMapOnLocation(initialLocation)
    }
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        print (coordinateRegion)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        print("im in here")
        if let loc = userLocation.location{
            mapView.centerCoordinate = loc.coordinate
        }
    }
}
