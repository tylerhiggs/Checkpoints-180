//
//  ViewController.swift
//  Checkpoints 180
//
//  Created by Tyler Higgs on 1/5/21.
//

import UIKit

class StartupViewController: UIViewController {
    
//    private let loginButton: MyButton = MyButton(self,"login", K.Color.blue, #selector(loginPressed(_:)))
//    private let signupButton: MyButton = MyButton(self,"signup", K.Color.pink, #selector(signupPressed(_:)))
    
    private let loginButton = MyButton(viewController: self, "login",K.Color.blue, #selector(loginPressed(_:)))
    private let signupButton = MyButton(viewController: self, "signup", K.Color.pink, #selector(signupPressed(_:)))
    
    private let buttonHeight = 60
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = K.Color.light
        
        // setup container for buttons
        
        let containerView = UIView()
        view.addSubview(containerView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: containerView)
        view.addConstraintsWithFormat(format: "V:[v0(\(buttonHeight))]-50-|", views: containerView)
        
        containerView.addSubview(loginButton)
        containerView.addSubview(signupButton)

        // put buttons in container
        
        let half = Int((Int(view.frame.width) - K.padding) / 2) - K.padding

        containerView.addConstraintsWithFormat(format: "H:|-\(K.padding)-[v0(\(half))]-\(K.padding)-[v1]-\(K.padding)-|", views: signupButton, loginButton)
        containerView.addConstraintsWithFormat(format: "V:|[v0]|", views: signupButton)
        containerView.addConstraintsWithFormat(format: "V:|[v0]|", views: loginButton)
        
        for b in [loginButton,signupButton] {
            b.layer.cornerRadius = CGFloat(buttonHeight / 2)
            b.titleLabel?.font = (UIFont(name: "System Medium", size: 30))
            b.titleLabel?.font = b.titleLabel?.font.withSize(30)
        }
    }
    

    
    @objc func loginPressed(_ b: UIButton) {
        print("login")
    }
    
    @objc func signupPressed(_ b: UIButton) {
        performSegue(withIdentifier: K.Segues.startupToSignup, sender: b)
    }


}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
        
        
    }
}



