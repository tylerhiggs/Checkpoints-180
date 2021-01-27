//
//  LoginViewController.swift
//  Checkpoints 180
//
//  Created by Tyler Higgs on 1/13/21.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate {
    
    private var userObj: GIDGoogleUser?
    private let signInButton = GIDSignInButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = K.googleClientID
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        self.clearNavigationBar()
        view.backgroundColor = K.Color.light
        
        view.addSubview(signInButton)
        view.addConstraintsWithFormat(format: "H:|-15-[v0]-15-|", views: signInButton)
        view.addConstraintsWithFormat(format: "V:[v0(75)]-50-|", views: signInButton)
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
          if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            print("The user has not signed in before or they have since signed out.")
          } else {
            print("\(error.localizedDescription)")
          }
          return
        }
        
        // Safe to send to the server
        // send to the server
        
        

        // Make a POST request so that the server can fetch the users information or show that this is a new user and create that user
        self.userObj = user
        //self.postLogin()
        
        performSegue(withIdentifier: K.Segues.loginToHome, sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.loginToHome {
            let destinationVC = segue.destination as! HomeViewController
            destinationVC.setUser(userObj)

        }
    }
    
    private func postLogin() {
        let idToken = self.userObj?.authentication.idToken
        if let token = idToken {
            let url = URL(string: "https://checkpoints-180.herokuapp.com/api/login-mobile")!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let parameters: [String: Any] = [
                "token": token
            ]
            request.httpBody = parameters.percentEncoded()

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
        }
    }
    

    
}
