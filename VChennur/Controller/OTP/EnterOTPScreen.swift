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
        print(mobileOtp)
        if mobileOTP == Int(mobileOtp) && mobileOtp.count >= 6{
            navigateToDestinationThrough(storyboardID: StoryboardId.ISSUES_VC)
        }else if registeredOTP == Int(mobileOtp) && mobileOtp.count >= 6{
            navigateToDestinationThrough(storyboardID: StoryboardId.LOGIN_VC)
        }else{
            KRProgressHUD.showWarning(withMessage: "Invalid OTP please check and try again")
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
