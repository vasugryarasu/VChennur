//
//  GenericVC.swift
//  VChennur
//
//  Created by Vasu Yarasu on 27/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit

class GenericVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func backToViewControlller(_sender: UIButton){
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
