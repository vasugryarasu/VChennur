//
//  VCForgotPasswordVC.swift
//  VChennur
//
//  Created by Vasu Yarasu on 20/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit
import KRProgressHUD
class VCForgotPasswordVC: GenericVC{
    @IBOutlet weak var userMobileNumberTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tappedOnSubmitBtn(_ sender: UIButton) {
        guard let phone = userMobileNumberTF.text else{return}
        let isValid = mobileNumberValidate(value: phone)
        
        if isValid{
            let posting = "phone=\(phone)"
            postServiceData(serviceURL: Service.FORGOT_PASSWORD, params: posting, type: ForgotPassword.self) { (forgotPasswordData) in
                guard let status = forgotPasswordData.status, let messaage = forgotPasswordData.message else{return}
                if status == 1{
                    KRProgressHUD.showMessage(messaage)
                    DispatchQueue.main.async {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }else{KRProgressHUD.showMessage(messaage)}
            }
        }else{
            KRProgressHUD.showError(withMessage: "Mobile Number is invalid. Please enter a valid mobile number")
        }
    }
}
