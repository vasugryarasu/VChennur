//
//  VCOTPScreen.swift
//  VChennur
//
//  Created by Vasu Yarasu on 22/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit
import KRProgressHUD

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
        let isValid = mobileNumberValidate(value: phone)
        loginWithOTP(isValidPhoneNumber: isValid,phoneNumber: phone)
    }
    
    func loginWithOTP(isValidPhoneNumber: Bool,phoneNumber: String){
        print(isValidPhoneNumber)
        if isValidPhoneNumber{
            let postString = "phone=\((phoneNumber))"
            //            print(postString)
            postServiceData(serviceURL: Service.LOGIN_URL, params: postString, type: GenerateOTP.self) { (userData) in
                guard let status = userData.status, let message = userData.message else{return}
                if status == 1{
                    DispatchQueue.main.async {
                        KRProgressHUD.showMessage(message)
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryboardId.ENTER_OTP) as! EnterOTPScreen
                        vc.modalTransitionStyle = .crossDissolve
                            let nav = UINavigationController(rootViewController: vc)
                            self.present(nav, animated: true, completion: nil)
                    }
                }else{
                    KRProgressHUD.showMessage(message)
                }
            }
        }else{
            alert(title: "Try Again", message: "Mobile Number is invalid. Please enter a valid mobile number", actions: UIAlertAction(title: "OK", style: .default, handler: nil))
        }
    }
}
