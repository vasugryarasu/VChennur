//
//  VCOTPScreen.swift
//  VChennur
//
//  Created by Vasu Yarasu on 22/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit

 var mobileOTP: Int?
class VCOTPScreen: UIViewController {
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var OTPTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
isNavigationHide(bool: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func mobileNumberSubmitBtn(_ sender: UIButton) {
        guard let phone = mobileNumberTF.text else{return}
        let isValid = mobielNumberValidate(value: phone)
        loginWithOTP(isValidPhoneNumber: isValid,phone: phone)}
    
     func loginWithOTP(isValidPhoneNumber: Bool,phone: String){
        print(isValidPhoneNumber)
        if isValidPhoneNumber{
            alert(title: "valid", message: "mobile number is valid")
            let postString = "phone=\((phone))"
            print(postString)
            postServiceData(serviceURL: Service.LOGIN_URL, params: postString, type: Otp.self) { (userData) in
                guard let otp = userData.otp else{return}
                mobileOTP = otp
                guard let mobile = userData.data?.phone else{return}
                guard let message = userData.message else{return}
                if phone == mobile{
                    print(phone) // toast
                }else{
                    self.alert(title: "Mobile Number", message:message)}
            }
        }else{
            alert(title: "Try Again", message: "Mobile Number is invalid. Please enter a valid mobile number")
        }
    }
    @IBAction func OTPSubmitBtn(_ sender: UIButton) {
        guard let mobileOtp = OTPTF.text else{return}
        if mobileOTP == Int(mobileOtp){
          navigateToDestinationThrough(storyboardID: StoryboardId.ISSUES_VC)
        }else{
            alert(title: "Invalid OTP", message: "Please check OTP")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
