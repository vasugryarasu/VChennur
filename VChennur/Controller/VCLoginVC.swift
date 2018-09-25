//
//  ViewController.swift
//  VNetha
//
//  Created by Vasu Yarasu on 19/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit

class VCLoginVC: UIViewController {

// MARK:- IBOutlets
    @IBOutlet weak var mobileNumberTF: TextField!
    @IBOutlet weak var passwordTF: TextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

//MARK:- UI Upadtes
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isNavigationHide(bool: true)
    }
    @IBAction func loginBtn(_ sender: UIButton) {
        login()
    }
    func login(){
        guard let phone = mobileNumberTF.text else{return}
        guard let password = passwordTF.text else{return}
        let postString = "phone=\(phone)&password=\(password)"
        postServiceData(serviceURL: Service.GENERAL_LOGIN, params: postString, type: GeneralLogin.self) { (userData) in
            guard let status = userData.status else{return}
            if status == 1{
                UserDefaults.standard.set("true", forKey: "status")
                Switcher.updateRootVC()
                }else{
                DispatchQueue.main.async {
                    self.alert(title: "Incorrect Username/Password", message: userData.message!)
                }
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
    @IBAction func goToSignIn(_ sender: UIStoryboardSegue) {}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

