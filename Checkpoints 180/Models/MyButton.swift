//
//  myButton.swift
//  Checkpoints 180
//
//  Created by Tyler Higgs on 1/6/21.
//

import UIKit

class MyButton: UIButton {
    
    required init(viewController: Any?, _ title: String, _ c: UIColor, _ selector: Selector) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(K.Color.light, for: .normal)
        self.backgroundColor = c
        self.addTarget(viewController, action: selector, for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}
