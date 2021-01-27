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
    private var token: String = ""

    
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
    func setToken(_ t: String) {
        self.token = t
    }
    
    private func postLocation(lat: String, lon: String) {
        if let id = self.user?.userID {
            let url = URL(string: "https://checkpoints-180.herokuapp.com/api/updateLocationGoogleId")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let parameters: [String: Any] = [
                "googleId": id,
                "lat": lat,
                "lon": lon,
            ]
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data,
                    let response = response as? HTTPURLResponse,
                    error == nil else {                                              // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
                }

                guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                    print("statusCode should be 2xx, but is \(response.statusCode)")
                    print("response = \(response)")
                    return
                }

                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString)")
            }

            task.resume()
        } else {
            print("no google id :(")
        }
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
            postLocation(lat: String(lat), lon: String(lon))

            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        print("ERRRRRRRRRROOORRRRRRR")
    }
    
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
