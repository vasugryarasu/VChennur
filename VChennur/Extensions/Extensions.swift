//
//  Extensions.swift
//  VChennur
//
//  Created by Vasu Yarasu on 21/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import Foundation
import UIKit

class VCButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let color = UIColor.white
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.frame.size.height/2
        self.tintColor = color
    }
}

class TextField: UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let color = UIColor.white
        let placeholderColor = UIColor.white
        guard let placeholder = self.placeholder else {return}
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
        self.textColor = color
        self.tintColor = color
        self.minimumFontSize = 17
        self.attributedPlaceholder = NSAttributedString(string: placeholder , attributes: [NSAttributedStringKey.foregroundColor: placeholderColor])
    }
}
extension UIView {
    func VCView(view: UIView){
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.layer.shadowRadius = 0.5
    }
}

extension UIViewController {
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
    
    func actionSheet(title: String, message: String, actions: UIAlertAction...){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions{
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
    
    func navigateToDestinationThrough(storyboardID: String){
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: storyboardID) else{return}
            self.navigationController?.pushViewController(vc, animated: true)
        }
}
    func isNavigationHide(bool: Bool){
        self.navigationController?.setNavigationBarHidden(bool, animated: true)
    }
    
    func mobielNumberValidate(value: String) -> Bool {
        let PHONE_REGEX = "^[6-9][0-9]{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
}







