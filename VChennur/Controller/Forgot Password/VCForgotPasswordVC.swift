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
        let isValid = mobielNumberValidate(value: phone)
        if isValid{
            let posting = "phone=\(phone)"
            postServiceData(serviceURL: Service.FORGOT_PASSWORD, params: posting, type: ForgotPassword.self) { (_) in
                DispatchQueue.main.async {
                    KRProgressHUD.showMessage("Your password send to your registered mobile number")
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }else{
//            alert(title: "Try Again", message: "Mobile Number is invalid. Please enter a valid mobile number")
            KRProgressHUD.showError(withMessage: "Mobile Number is invalid. Please enter a valid mobile number")
            
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
