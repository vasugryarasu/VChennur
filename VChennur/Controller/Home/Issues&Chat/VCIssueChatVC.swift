//
//  VCIssueChatVC.swift
//  VChennur
//
//  Created by Vasu Yarasu on 28/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit
import KRProgressHUD



class VCIssueChatVC: GenericVC, UITableViewDelegate,UITableViewDataSource {
  
    let cellID = "ChatCell"
    var chatingData = [ChatData]()

    @IBOutlet weak var issueChatTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        issueChatTV.register(ChatCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        issueChatTV.reloadData()
        getChattingData()
    }
    
    func getChattingData(){
        let issueId = UserDefaults.standard.value(forKey: "id") as! String
        let userId = UserDefaults.standard.value(forKey: "user_id") as! String
        let userType = UserDefaults.standard.value(forKey: "user_type") as! String
        
        switch userType {
        case "user":
            let postString = "issue_id=\(issueId)&user_id=\(userId)"
            //print(postString)
            postServiceData(serviceURL: Service.GET_ISSUE_CHAT, params: postString, type: ExecutiveIssueChat.self) { (chatData) in
                guard let status = chatData.status, let message = chatData.message else{return}
                if status == 1{
                    KRProgressHUD.dismiss()
                    guard let chatDetails = chatData.data else {return}
                    self.chatingData = chatDetails
                    DispatchQueue.main.async {
                        self.issueChatTV.reloadData()
                    }
                }else{KRProgressHUD.showMessage(message)}
                
            }
        case "executive":
            let postString = "issue_id=\(issueId)"
            postServiceData(serviceURL: Service.GET_EXECUTIVE_ISSUE_CHAT, params: postString, type: ExecutiveIssueChat.self) { (chatData) in
                guard let status = chatData.status , let message = chatData.message else {return}
                if status == 1{
                    KRProgressHUD.dismiss()
                    guard let chatDetails = chatData.data else {return}
                    self.chatingData = chatDetails
                    DispatchQueue.main.async{
                        self.issueChatTV.reloadData()
                    }
                }else{
                    KRProgressHUD.showMessage(message)
                }
            }
        default:
            print("No data")
        }
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatingData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)as!ChatCell
        let userData = chatingData[indexPath.row]
        let userType = userData.userType?.rawValue
        switch userType {
        case "user":
            cell.isAdmin = false
            cell.chatLabel.text = userData.description
            cell.chatTime.text = userData.datetime
        case "admin":
            cell.isAdmin = true
            cell.chatLabel.text = userData.description
            cell.chatTime.text = userData.datetime

        default:
            print("no Issues")
        }
        return cell
    }

   
}
