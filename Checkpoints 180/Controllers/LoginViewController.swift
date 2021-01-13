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
        
//      let idToken = user.authentication.idToken // Safe to send to the server

        // Make a POST request so that the server can fetch the users information or show that this is a new user and create that user
        self.userObj = user
        performSegue(withIdentifier: K.Segues.loginToHome, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.loginToHome {
            let destinationVC = segue.destination as! HomeViewController
            destinationVC.setUser(userObj)
        }
    }
    
}
