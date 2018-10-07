//
//  GenericVC.swift
//  VChennur
//
//  Created by Vasu Yarasu on 27/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit

class GenericVC: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func backToViewControlller(_sender: UIButton){
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
