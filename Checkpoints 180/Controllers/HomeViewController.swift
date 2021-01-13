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
        view.backgroundColor = K.Color.light
        navigationController?.navigationBar.barTintColor = K.Color.pink
        navigationController?.navigationBar.isTranslucent = false

        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Checkpoints 180"
        //self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 500)
//        self.navigationController?.navigationBar.backgroundColor = K.Color.pink
        let font = UIFont(name: K.fontName, size: 30)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font,
                                                                        NSAttributedString.Key.foregroundColor: K.Color.light]

    }
    
    
    func setUser(_ u: GIDGoogleUser!) {
        self.user = u
    }
    
}
