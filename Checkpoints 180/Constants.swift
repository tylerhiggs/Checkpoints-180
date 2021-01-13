//
//  Constants.swift
//  Checkpoints 180
//
//  Created by Tyler Higgs on 1/5/21.
//

import UIKit

struct K {
    
    static let padding = 20
    
    static let fontName = "PingFangHK-Medium"
    
    struct Color {
        static let pink = UIColor(named: "myPink")!
        static let light = UIColor(named: "myLight")!
        static let green = UIColor(named: "myGreen")!
        static let blue = UIColor(named: "myBlue")!
    }
    
    struct Segues {
        static let startupToSignup = "startupToSignup"
        static let signupToHome = "signupToHome"
        static let loginToHome = "loginToHome"
        static let startupToLogin = "startupToLogin"
    }
    
    static let googleClientID = "542548052137-83gi15re56h4el48v4mjc6qc4oh8sg4j.apps.googleusercontent.com"
    
}
