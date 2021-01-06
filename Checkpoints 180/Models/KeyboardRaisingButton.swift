//
//  KeyboardRaisingButton.swift
//  Checkpoints 180
//
//  Created by Tyler Higgs on 1/5/21.
//

import UIKit

class KeyboardRaisingButton: UIButton {
    
    private var selectable = false
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.alpha = self.isHighlighted ? 0.5 : 1
            }, completion: nil)
        }
    }
    
    static func button(_ viewController: Any?, _ title: String, _ selector: Selector) -> KeyboardRaisingButton {
        let b = KeyboardRaisingButton()
        b.setTitle(title, for: .normal)
        b.titleLabel?.font = UIFont(name: "System Medium", size: 20)
        b.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        b.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        b.layer.cornerRadius = 21
        b.addTarget(viewController, action: selector, for: .touchUpInside)
        return b
    }
    
    func constrain(_ viewController: Any?, _ view: UIView) -> NSLayoutConstraint{
        
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        self.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.heightAnchor.constraint(equalToConstant: 42).isActive = true
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -30)
        view.addConstraint(bottomConstraint)

        return bottomConstraint
    }
    
}

