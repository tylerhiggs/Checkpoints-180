//
//  NavBarHelper.swift
//  Checkpoints 180
//
//  Created by Tyler Higgs on 1/11/21.
//

import UIKit

extension UIViewController {
    func clearNavigationBar() {
        // makes the navigation bar invisible while keeping it there (keeps the back button)
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
    }
}
