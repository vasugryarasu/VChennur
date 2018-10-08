//
//  EnterOTPScreen.swift
//  VChennur
//
//  Created by Vasu Yarasu on 26/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit
import KRProgressHUD

class EnterOTPScreen: GenericVC {
    
    @IBOutlet weak var OTPTF: UITextField!
    @IBOutlet weak var OtpSubmitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func OTPSubmitBtn(_ sender: UIButton) {
        guard let mobileOtp = OTPTF.text else{return}
        let postString = "otp=\(mobileOtp)"
        postServiceData(serviceURL: Service.CHECK_OTP_URL, params: postString, type: GeneralLogin.self) { (OtpData) in
            
            guard let status = OtpData.status , let message = OtpData.message, let userType = OtpData.userType else{return}
            if status == 1{
                KRProgressHUD.dismiss()
                guard let userData = OtpData.data else{return}
                guard let userId = userData.userId,
                    let name = userData.firstName,
                    let phoneNumber = userData.phone,
                    let villageId = userData.villageId,
                    let image = userData.image else {return}
                
                UserDefaults.standard.set("true", forKey: "status")
                UserDefaults.standard.set("\(userType)", forKey: "user_type")
                UserDefaults.standard.set("\(userId)", forKey: "user_id")
                UserDefaults.standard.set("\(name)", forKey: "first_name")
                UserDefaults.standard.set("\(phoneNumber)", forKey: "phone")
                UserDefaults.standard.set("\(villageId)", forKey: "village_id")
                UserDefaults.standard.set("\(image)", forKey: "image")
                Switcher.updateRootVC()
                KRProgressHUD.showSuccess(withMessage: message)
                
            }else{
                KRProgressHUD.showMessage(message)
            }
        }
        if fromSignUp == "fromSignUpVC"{
            postServiceData(serviceURL: Service.CHECK_OTP_URL, params: postString, type: GeneralLogin.self) { (OtpData) in
                guard let status = OtpData.status , let message = OtpData.message else{return}
                if status == 1{
                    KRProgressHUD.dismiss()
                    DispatchQueue.main.async {
                        self.navigateToDestinationThrough(storyboardID: StoryboardId.MENU_NAVIGATION_VC)
                    }
                }else{
                        KRProgressHUD.showMessage(message)
                    }
                }
            }
        }
}
