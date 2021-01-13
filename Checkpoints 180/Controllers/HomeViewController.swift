//
//  HomeViewController.swift
//  Checkpoints 180
//
//  Created by Tyler Higgs on 1/12/21.
//

import UIKit
import GoogleSignIn

class HomeViewController: UIViewController {
    
    private var user: GIDGoogleUser?
    
    override func viewDidLoad() {
        
        //..
        print("made it")
        view.backgroundColor = K.Color.pink
        print(user?.profile.name)
    }
    
    
    func setUser(_ u: GIDGoogleUser!) {
        self.user = u
    }
    
}
