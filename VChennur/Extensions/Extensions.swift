//
//  Extensions.swift
//  VChennur
//
//  Created by Vasu Yarasu on 21/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
//MARK:- ALERT VIEW **********
    
    func alert(title: String, message: String, actions: UIAlertAction...) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions{
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
 
    func actionSheet(title: String, message: String, actions: UIAlertAction...){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions{
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
    
    func cellularDataAlert(){
        alert(title: "Cellular data is turned off", message: "Turn on cellular data or use Wi-fi to access data", actions: UIAlertAction(title: "Cancel", style: .cancel, handler: nil), UIAlertAction(title: "Settings", style: .default, handler: { (alert) in
            UIApplication.shared.open(URL(string:"App-Prefs:root=General")!, options: [:], completionHandler: nil)
        }))
    }

    //MARK:- NAVIGATION CONTROLLER *************
    func navigateToDestinationThrough(storyboardID: String){
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: storyboardID) else{return}
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
}
    func mobielNumberValidate(value: String) -> Bool {
        let PHONE_REGEX = "^[6-9][0-9]{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    
}







