//
//  VCOTPScreen.swift
//  VChennur
//
//  Created by Vasu Yarasu on 22/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit
import KRProgressHUD

 var mobileOTP: Int?
class VCOTPScreen: GenericVC {
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var phoneSubmitBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func mobileNumberSubmitBtn(_ sender: UIButton) {
        guard let phone = mobileNumberTF.text else{return}
        let isValid = mobielNumberValidate(value: phone)
        loginWithOTP(isValidPhoneNumber: isValid,phoneNumber: phone)}
    
     func loginWithOTP(isValidPhoneNumber: Bool,phoneNumber: String){
        print(isValidPhoneNumber)
        if isValidPhoneNumber{
            
            let postString = "phone=\((phoneNumber))"
            print(postString)
            postServiceData(serviceURL: Service.LOGIN_URL, params: postString, type: Otp.self) { (userData) in
                guard let otp = userData.otp else{return}
                mobileOTP = otp
                guard let received = userData.data?.phone else{return}
//                guard let message = userData.message else{return}
                if phoneNumber == received{
                    KRProgressHUD.showSuccess(withMessage: "OTP sent to your registered mobile number")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryboardId.ENTER_OTP) as! EnterOTPScreen
                    vc.modalTransitionStyle = .crossDissolve
                    DispatchQueue.main.async {
                        self.present(vc, animated: true, completion: nil)
                    }
                    print(phoneNumber) // toast
                }else{}
            }
        }else{
alert(title: "Try Again", message: "Mobile Number is invalid. Please enter a valid mobile number", actions: UIAlertAction(title: "OK", style: .default, handler: nil))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
