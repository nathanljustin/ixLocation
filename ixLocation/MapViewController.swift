//
//  MapViewController.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/5/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import Gloss

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, AddDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    var locationManager: CLLocationManager!
    var currentUserLocation: CLLocation!
    var activities: [Activity] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // A region represents the area of the map that we want to view
        // It consists of a location (CLLocationCoordinate2D) and a Span (MKCoordinateSpanMak)
        let location = CLLocationCoordinate2D(latitude: -33.918861,longitude: 18.423300)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        // Always show the users location
        map.showsUserLocation = true
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        //locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
        Alamofire.request("https://ixlocation-689b0.firebaseio.com/activities.json").responseJSON { response in
            //print(response.request)  // original URL request
            //print(response.response) // HTTP URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                if let response = JSON as? NSDictionary {
                
                for (key, value) in response {
                    let activity = Activity()
                    
                    if let actDictionary = value as? [String : AnyObject] {
                        activity?.name = actDictionary["name"] as! String
                        activity?.description = actDictionary["description"] as! String
                        activity?.locationName = actDictionary["locationName"] as! String
                        activity?.date = actDictionary["date"] as! String
                        
                        if let geoPointDictionary = actDictionary["location"] as? [String: AnyObject] {
                            let location = GeoPoint()
                            location.lat = (geoPointDictionary["lat"] as? Double)!
                            location.lng = (geoPointDictionary["lng"] as? Double)!
                            activity?.location = location
                            
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2DMake((activity?.location.lat)!, (activity?.location.lng)!);
                            annotation.title = activity?.name
                            self.map.addAnnotation(annotation)
                        }
                    }
                    
                    self.activities.append(activity!)
                }
                }
            }
        }

        
        setMapType()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setMapType()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Get the users location from the array of locations
        let userLocation: CLLocation = locations[0] as CLLocation
        
        // You can call stopUpdatingLocation() to stop listening for location updates
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        // Store reference to the users location in the class instance (self)
        self.currentUserLocation = userLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        // An error occurred trying to retrieve users location
        print("Error \(error)")
    }
    
    func setMapType() {
        let mapType = UserDefaults.standard.string(forKey: "mapType")
        
        if mapType != nil {
            
            if mapType == "hybrid" {
                map.mapType = .hybrid
            }
            
            if mapType == "satellite" {
                map.mapType = .satellite
            }
            
            if mapType == "standard" {
                map.mapType = .standard
            }
        }
    }
    
    func didSaveActivity(activity: Activity) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake((activity.location.lat), (activity.location.lng));
        annotation.title = activity.name
        map.addAnnotation(annotation)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationViewController = segue.destination as! UINavigationController
        
        let addViewController = navigationViewController.topViewController as! AddViewController
        
        addViewController.delegate = self
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate
        userLocation: MKUserLocation) {
        map.centerCoordinate = userLocation.location!.coordinate
    }
    
}

