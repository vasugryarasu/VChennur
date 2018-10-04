//
//  VCChatReplyVC.swift
//  VChennur
//
//  Created by Vasu Yarasu on 29/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit
import KRProgressHUD

class VCChatReplyVC: GenericVC,UITextViewDelegate {
    @IBOutlet weak var chatReplyTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatReplyTV.delegate = self
        chatReplyTV.text = "Type issue description.."
        chatReplyTV.textColor = .lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if chatReplyTV.textColor == .lightGray {
            chatReplyTV.text = nil
            chatReplyTV.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type issue description.."
            textView.textColor = .lightGray
        }
    }
    
    @IBAction func onTappedAddFiles(_ sender: UIButton) {
    }
    
    @IBAction func onTappedSubmitBtn(_ sender: UIButton) {
        let userID = UserDefaults.standard.value(forKey: "user_id") as! String
        guard let issueId = issueID ,let chatMessage = chatReplyTV.text else{return}
        print(issueId)
        //if we want to send only text pass 0 (or) image 1  (or) voice 2
        let fileType = 0
        let postString = "user_id=\(userID)&issue_id=\(issueId)&description=\(chatMessage)&file_type=\(fileType)"
        postServiceData(serviceURL: Service.ADD_ISSUE_CHAT, params: postString, type: Chatreply.self) { (replyStatus) in
            guard let status = replyStatus.status, let message = replyStatus.message else{return}
            if status == 1{
                KRProgressHUD.showMessage(message)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                KRProgressHUD.showMessage(message)
            }
        }
    }
}
