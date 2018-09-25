//
//  IssuesVC.swift
//  VNetha
//
//  Created by Vasu Yarasu on 19/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit

class VCIssuesVC: UIViewController {
 var isMenuShowing: Bool = false

    @IBOutlet weak var menuBackgroundColor: UIView!
    @IBOutlet weak var leadingConstaint: NSLayoutConstraint!
        override func viewDidLoad() {
        super.viewDidLoad()
            isNavigationHide(bool: false)
            leadingConstaint.constant = -230
            menuBackgroundColor.alpha = 0
            viewTapped()
    }
    func viewTapped(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(menuBtn(_:)))
        menuBackgroundColor.addGestureRecognizer(tapGesture)
        menuBackgroundColor.isUserInteractionEnabled = true
    }
    
    
    @IBAction func menuBtn(_ sender: UIBarButtonItem) {

        print("btn pressed")
        if isMenuShowing{
            leadingConstaint.constant = -230
            menuBackgroundColor.alpha = 0
        }else{
            leadingConstaint.constant = 0
            menuBackgroundColor.alpha = 0.5
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
        isMenuShowing = !isMenuShowing

    }
    @IBAction func tappedOnSignOutBtn(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(false, forKey: "status")
        Switcher.updateRootVC()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension VCIssuesVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssuesCell", for: indexPath) as! IssuesCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
}
