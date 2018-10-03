//
//  IssuesVC.swift
//  VNetha
//
//  Created by Vasu Yarasu on 19/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit
import KRProgressHUD

var selectedIndex: Int = 0

class VCIssuesVC: GenericVC{
    
    var userIssuesArr = [UserIssue]()
    var executiveIssueArr = [ExecutiveIssue]()
    
    var isMenuShowing: Bool = false
    let userType = UserDefaults.standard.value(forKey: "user_type") as! String
    
    @IBOutlet weak var menuBackgroundColor: UIView!
    @IBOutlet weak var leadingConstaint: NSLayoutConstraint!
    @IBOutlet weak var issuesTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        leadingConstaint.constant = -230
        menuBackgroundColor.alpha = 0
        tappedOnView()
       dashBoardUserOrExecutive()
    }
    func tappedOnView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(menuBtn(_:)))
        menuBackgroundColor.addGestureRecognizer(tapGesture)
        menuBackgroundColor.isUserInteractionEnabled = true
    }
    func dashBoardUserOrExecutive() {
        let userId = UserDefaults.standard.value(forKey: "user_id")as! String
        switch userType {
        case "user":
            let postString = "user_id=\(userId)"
            postServiceData(serviceURL: Service.ISSUE_LIST, params: postString, type: UserIssueList.self) { (issuesList) in
                guard let issueData = issuesList.data else{return}
                KRProgressHUD.dismiss()
                for issue in 0 ..< issueData.count{
                    self.userIssuesArr.append(issueData[issue])
//                    print(self.userIssuesArr)
                    DispatchQueue.main.async {
                        self.issuesTV.reloadData()
                    }
                }
            }
        case "executive":
            let postString = "executive_id=\(userId)"
            postServiceData(serviceURL: Service.ISSUE_LIST_EXECUTIVE, params: postString, type: ExecutiveList.self) { (issuesList) in
                guard let issueData = issuesList.data else{return}
                KRProgressHUD.dismiss()
                for issue in 0 ..< issueData.count{
                    self.executiveIssueArr.append(issueData[issue])
                }
                DispatchQueue.main.async {
                    self.issuesTV.reloadData()
                }
            }
        default: break
        }
    }
    
    @IBAction func menuBtn(_ sender: UIButton) {
        
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
    @IBAction func tappedOnSignOutBtn(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "status")
        Switcher.updateRootVC()
    }
    @IBAction func addNewIssueBtn(_ sender: UIButton) {
        switch userType {
        case "user":
            self.navigateToDestinationThrough(storyboardID: StoryboardId.ADD_ISSUE_VC)
        case "executive":
            self.navigateToDestinationThrough(storyboardID: StoryboardId.EXECUTIVE_ADD_ISSUE)
        default: break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension VCIssuesVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch userType {
        case "user":
            return userIssuesArr.count
        case "executive":
            return executiveIssueArr.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssuesCell", for: indexPath) as! IssuesCell
        cell.selectionStyle = .none
        
        switch userType {
        case "user":
            let user = userIssuesArr[indexPath.row]
            cell.issueIdLbl.text = user.issueId
            cell.issueNameLbl.text = user.name
            cell.issueTimeLbl.text = user.datetime
            cell.status.text = user.workStatus
        case "executive":
            let executive = executiveIssueArr[indexPath.row]
            cell.issueIdLbl.text = executive.issueId
            cell.issueNameLbl.text = executive.name
            cell.issueTimeLbl.text = executive.datetime
            cell.status.text = executive.workStatus?.rawValue
        default:
            print("no data")
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
       navigateToDestinationThrough(storyboardID: StoryboardId.ISSUE_DETAIL_CHAT_VC)
        
    }
    
}
