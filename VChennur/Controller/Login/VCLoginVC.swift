//
//  ViewController.swift
//  VNetha
//
//  Created by Vasu Yarasu on 19/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit
import KRProgressHUD


class VCLoginVC: GenericVC {
    
    // MARK:- IBOutlets
    @IBOutlet weak var mobileNumberTF: TextField!
    @IBOutlet weak var passwordTF: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mobileNumberTF.delegate = self
        passwordTF.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func loginBtn(_ sender: UIButton) {
        login()
    }
    func login(){
        guard let phone = mobileNumberTF.text,
            let password = passwordTF.text else{return}
        
        let postString = "phone=\(phone)&password=\(password)"
        postServiceData(serviceURL: Service.GENERAL_LOGIN, params: postString, type: GeneralLogin.self) { (userData) in
            
            guard let status = userData.status,
                let message = userData.message else{return}
            if status == 1{
                KRProgressHUD.dismiss()
                UserDefaults.standard.set("true", forKey: "status")
                guard let userType = userData.userType,
                    let userId = userData.data?.userId,
                    let name = userData.data?.firstName,
                    let phoneNumber = userData.data?.phone,
                    let villageId = userData.data?.villageId,
                    let image = userData.data?.image else{return}
                
                
                UserDefaults.standard.set("\(userType)", forKey: "user_type")
                UserDefaults.standard.set("\(userId)", forKey: "user_id")
                UserDefaults.standard.set("\(name)", forKey: "first_name")
                UserDefaults.standard.set("\(phoneNumber)", forKey: "phone")
                UserDefaults.standard.set("\(villageId)", forKey: "village_id")
                UserDefaults.standard.set("\(image)", forKey: "image")
                KRProgressHUD.showSuccess(withMessage: message)
                Switcher.updateRootVC()
            }else{
                KRProgressHUD.showWarning(withMessage: message)
            }
        }
    }
    @IBAction func forgotPasswordBtn(_ sender: UIButton) {
        navigateToDestinationThrough(storyboardID: StoryboardId.FORGOT_PASSWORD)
    }
    @IBAction func loginOTP(_ sender: UIButton) {
        navigateToDestinationThrough(storyboardID: StoryboardId.OTP_VC)
    }
    @IBAction func signUpBtn(_ sender: UIButton) {
        navigateToDestinationThrough(storyboardID: StoryboardId.SIGNUP_VC)
    }
    @IBAction func goToSignIn(_ sender: UIStoryboardSegue) {print("tapped")}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

