//
//  MapDetailsViewController.swift
//  ParentApp
//
//  Created by Youm7 on 8/10/20.
//  Copyright © 2020 Test.iosapp. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import GeoFire
class MapDetailsViewController: UIViewController,GMSMapViewDelegate {
    @IBOutlet weak var viewForGoogleMap: UIView!
    var firstload = false
    var mappView:GMSMapView?
    var marker = GMSMarker()
    let geocoder = GMSGeocoder()
    var sfQuery: GFQuery!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var markerView = UIImageView(image: UIImage(named: "Map_TabBarIcon_color"))
    var finalcoordinates = CLLocationCoordinate2D()
    let geofireRef = Database.database().reference().child("users")
    var users: User!
    var handle: AuthStateDidChangeListenerHandle?
    override func viewDidLoad() {
        super.viewDidLoad()
        let AddConditionBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOut))
        self.navigationItem.rightBarButtonItem  = AddConditionBarButtonItem
        self.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = UIColor.maincolor
        
        self.title = "Location"
        checkLocationPermission()
        
        // Do any additional setup after loading the view.
    }
    @objc func logOut(){
        let userStoryBoard = UIStoryboard(name: "User", bundle: nil)
        let vc = userStoryBoard.instantiateViewController(withIdentifier: "LoginNav")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
        
    }
    func checkLocationPermission()  {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                currentLocation = locationManager.location
                creategooglemap()
            }
        } else {
            print("Location services are not enabled")
        }
    }
    func  creategooglemap(){
        let camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude:currentLocation.coordinate.longitude, zoom: 16.0)
        
        mappView = GMSMapView.map(withFrame: viewForGoogleMap.bounds, camera: camera)
        
        mappView?.center = self.viewForGoogleMap.center
        mappView?.settings.myLocationButton = true
        mappView?.isMyLocationEnabled = true
        mappView?.delegate = self
        mappView?.padding = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
        self.viewForGoogleMap.addSubview(mappView!)
        
        // Creates a marker in the center of the map.
        marker.iconView = markerView
        
        marker.position = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        //        marker.title = "Sydney"
        //        marker.snippet = "Australia"
        marker.map = mappView
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            let geoFire = GeoFire(firebaseRef: self.geofireRef)
            
            geoFire.setLocation(self.currentLocation, forKey: "\(user!.uid)") { (error) in
                if (error != nil) {
                    print("An error occured: \(String(describing: error))")
                } else {
                    print("Saved location successfully!")
                }
            }
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.animate(toLocation: marker.position)
        
        return true
    }
    
}
extension MapDetailsViewController {
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if firstload{
            var destinationLocation = CLLocation()
            destinationLocation = CLLocation(latitude: position.target.latitude,  longitude: position.target.longitude)
            let destinationCoordinate = destinationLocation.coordinate
            updateLocationoordinates(coordinates: destinationCoordinate)
            geocoder.reverseGeocodeCoordinate(destinationCoordinate) { response, error in
                //
                if error != nil {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                } else {
                    if let places = response?.results() {
                        if let place = places.first {
                            
                            
                            if let lines = place.lines {
                                print("GEOCODE: Formatted Address: \(String(describing: lines.first))")
                                
                            }
                            
                        } else {
                            print("GEOCODE: nil first in places")
                        }
                    } else {
                        print("GEOCODE: nil in places")
                    }
                }
            }
            
        }
        firstload = true
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if firstload{
            if let location = locations.last {
                handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                    let geoFire = GeoFire(firebaseRef: self.geofireRef)
                    
                    geoFire.setLocation(location, forKey: "\(user!.uid)") { (error) in
                        if (error != nil) {
                            print("An error occured: \(String(describing: error))")
                        } else {
                            print("Saved location successfully!")
                        }
                    }
                }
                
            }
        }
        firstload = true
        
    }
    func updateLocationoordinates(coordinates:CLLocationCoordinate2D) {

            CATransaction.begin()
            marker.position =  coordinates
            CATransaction.commit()
        
        
    }
}
