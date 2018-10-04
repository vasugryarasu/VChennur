//
//  VCIssueDetailAndChatVC.swift
//  VChennur
//
//  Created by Vasu Yarasu on 28/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit
import PageMenu

class VCIssueDetailAndChatVC: GenericVC {
    
    @IBOutlet weak var replyBtn: UIButton!
    
    var pageMenu: CAPSPageMenu?
    let userType = UserDefaults.standard.value(forKey: "user_type") as! String

    override func viewDidLoad() {
        super.viewDidLoad()
        
     issueDetailsAndChatViewControllers()
        
    }
    
    func issueDetailsAndChatViewControllers() {
                switch userType {
                case "user":
                    replyBtn.isHidden = false
                case "executive":
                    replyBtn.isHidden = true
                default:
                    print("NoAction")
                }

        var controllerArray: [UIViewController] = []
        let firstVC = storyboard?.instantiateViewController(withIdentifier: StoryboardId.ISSUE_DETAIL_VC)
        firstVC?.title = "Issue Details"
        let secondVC = storyboard?.instantiateViewController(withIdentifier: StoryboardId.ISSUE_CHAT_VC)
        secondVC?.title = "Issue Chat"

        controllerArray.append(firstVC!)
        controllerArray.append(secondVC!)
        
        // a bunch of random customization
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(.init(red: 51/225, green: 139/225, blue: 223/255, alpha: 1)),
            .viewBackgroundColor(.white),
            .selectionIndicatorColor(.white),
            .bottomMenuHairlineColor(.white),
            .menuHeight(50),
            .menuItemWidth(self.view.frame.width/2),
            .centerMenuItems(true),
            .selectedMenuItemLabelColor(.white),
            .unselectedMenuItemLabelColor(.black),
            .menuMargin(0.0),]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x:0,y:66,width:self.view.frame.width ,height:self.view.frame.height) , pageMenuOptions: parameters)

        self.view.addSubview(pageMenu!.view)
        
    }
    @IBAction func userOnTappedReplyBtn(_ sender: UIButton) {
        navigateToDestinationThrough(storyboardID: StoryboardId.CHAT_REPLY)
    }
   
}
