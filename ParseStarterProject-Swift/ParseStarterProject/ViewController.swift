/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import MapKit
import Parse

class ViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {
    let MY_PLAYER=0, OTHER_PLAYER=1
    let regionRadius: CLLocationDistance = 500
    let locationManager = CLLocationManager()
    var playerLocationSet = false
    
    var players = [Assassin]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func MoveUp(sender: UIButton) {
        let push = PFPush()
        push.setChannel("Channel1")
        push.setMessage("This is a Push!")
        push.sendPushInBackground()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // this code needs to be moved into CoreLocation location updates area
        // Corresponds to Los Angeles
        // TODO dynamically set lat long to current coordinate
        mapView.delegate = self
        locationManager.delegate = self
        
        guard CLLocationManager.locationServicesEnabled() else {
            print("*** Location Services Not Enabled ***")
            locationDataUnavaialble()
            return
        }
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestAlwaysAuthorization()
        }
   
    }
    private func locationDataUnavaialble() {
        // .. do something here...
        print("*** Do Not Have Access to Location Data ***")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status {
        case .AuthorizedAlways:
            setupLocationData()
        case .AuthorizedWhenInUse:
            setupLocationData()
        case .Denied:
            locationDataUnavaialble()
        case .NotDetermined:
            locationDataUnavaialble()
        case .Restricted:
            locationDataUnavaialble()
        }
    }
    
    
    private func setupLocationData() {
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        //locationManager.requestLocation()
        //setupPlayerLocations()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation = locations.last!
        
        if playerLocationSet {
            players[MY_PLAYER].setLocation(newLocation.coordinate)
            centerMapOnCoordinate(players[MY_PLAYER].coordinate)
            print(players[MY_PLAYER].geoPoint)
        } else {
            print("setting up locs")
            setupPlayerLocations()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("errrrrrorrrrrr")
        print(error)
    }
    
    private func setupPlayerLocations() {
        var myAssassin: Assassin
        
        if let myloc=locationManager.location{
            print("in san fran")
            myAssassin = Assassin(name: "User", coordinate: myloc.coordinate)
        }
        else{
            print("in los ang")
            myAssassin = Assassin(name:"User", coordinate: CLLocationCoordinate2D(latitude: 34.054, longitude: -118.203))
        }
        
        
        let alat2=myAssassin.coordinate.latitude+0.001;
        let along2=myAssassin.coordinate.longitude+0.001;
        
        
        let assassin2 = Assassin(name: "Player", coordinate: CLLocationCoordinate2D(latitude: alat2, longitude: along2))
        
        
        players.append(myAssassin);
        players.append(assassin2);
        
        
        //        let initialLocation = CLLocation(latitude: players[MY_PLAYER].coordinate.latitude ,longitude: players[0].coordinate.longitude)
        mapView.addAnnotation(players[OTHER_PLAYER])
        
        
        centerMapOnCoordinate(players[MY_PLAYER].coordinate)
        
        playerLocationSet = true

    }
    func centerMapOnLocation(location: CLLocation) {
        mapView.setCenterCoordinate(location.coordinate, animated: true)
        
    }
    func centerMapOnCoordinate(coordinate: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}
