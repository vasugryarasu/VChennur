//
//  Switcher.swift
//  VChennur
//
//  Created by Vasu Yarasu on 24/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import Foundation
import UIKit

class Switcher {
    static func updateRootVC(){
        let status = UserDefaults.standard.bool(forKey: "status")
        var rootVC : UIViewController?
        print(status)
        
        if status{
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: StoryboardId.MENU_NAVIGATION_VC)
        }else{
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: StoryboardId.NAVIGATION_VC)
        }
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = rootVC
        }
    }
    }
