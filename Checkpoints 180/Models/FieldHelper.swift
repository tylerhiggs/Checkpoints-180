//
//  FieldHelper.swift
//  Checkpoints 180
//
//  Created by Tyler Higgs on 1/5/21.
//

import UIKit

struct FieldHelper {
    

    
    static func keyboardWillChange(notification: Notification, _ bottomConstraint: NSLayoutConstraint?, _ view: UIView) {
        if notification.userInfo != nil {
            guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
            }
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardRect.height - 30 : -30
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                view.layoutIfNeeded()
            }) { (completed) in
                
            }
            
        }
    }
    
    static func fieldsEdited(_ sender: UITextField, _ button: UIButton, _ fields: UITextField...) {
        let text = sender.text ?? ""
        let trimmedText = text.trimmingCharacters(in: .whitespaces)
        sender.text = trimmedText
        
        var hasEmpty = false
        for field in fields {
            if field.text == "" || field.text == nil {
                hasEmpty = true
                break
            }
        }
        
        if hasEmpty {
            button.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        } else {
            button.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
        }
        
        if text != "" {
            sender.autocorrectionType = .no
            sender.reloadInputViews()
        } else {
            sender.autocorrectionType = .yes
            sender.reloadInputViews()
        }
    }
}
