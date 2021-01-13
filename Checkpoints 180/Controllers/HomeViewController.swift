//
//  HomeViewController.swift
//  Checkpoints 180
//
//  Created by Tyler Higgs on 1/12/21.
//

import UIKit
import GoogleSignIn
import CoreLocation

class HomeViewController: UIViewController {
    
    private var user: GIDGoogleUser?
    private let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        view.backgroundColor = K.Color.light
        navigationController?.navigationBar.barTintColor = K.Color.pink
        navigationController?.navigationBar.isTranslucent = false

        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Checkpoints 180"

        let font = UIFont(name: K.fontName, size: 30)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font,
                                                                        NSAttributedString.Key.foregroundColor: K.Color.light]
        
        
        // Location
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

    }
    
    
    func setUser(_ u: GIDGoogleUser!) {
        self.user = u
    }
    
    
}


//MARK: - Location Delagate

extension HomeViewController: CLLocationManagerDelegate {
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            // do stuff with lat and lon
            print(lat,lon)
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        print("ERRRRRRRRRROOORRRRRRR")
    }
    
}
