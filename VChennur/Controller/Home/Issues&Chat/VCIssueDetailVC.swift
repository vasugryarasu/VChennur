//
//  VCIssueDetailVC.swift
//  VChennur
//
//  Created by Vasu Yarasu on 28/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit
import KRProgressHUD

var issueID: String?
class VCIssueDetailVC: GenericVC ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var imageData: [String] = []

    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var issueIdLbl: UILabel!
    @IBOutlet weak var issueCategoryLbl: UILabel!
    @IBOutlet weak var issueTimeLbl: UILabel!
    @IBOutlet weak var issueStatusLbl: UILabel!
    @IBOutlet weak var issueNameLbl: UILabel!
    @IBOutlet weak var issueDescriptionTV: UITextView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      issueDetails()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageData.count
        //        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "issueImagesCell", for: indexPath) as! IssueImageCell
        //        cell.issueImage.image = UIImage(named: "VChennur.jpg")
        let url = URL(string:imageData[indexPath.row])
        if let data = try? Data(contentsOf: url!)
        {
            cell.issueImage.image = UIImage(data: data)
        }
        return cell
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        //       let postString = "issue_id=\(issueId)"
        //        print(postString)
        //        postServiceData(serviceURL: Service.GET_ISSUE_IMAGES, params: postString, type: GetImages.self) { (getImages) in
        //            guard let images = getImages.data else{return}
        //            for i in 0 ..< images.count{
        //                guard let image = images[i].image else{return}
        //                self.imageData.append(image)
        //                print(self.imageData)
        //
        //            }
        //            DispatchQueue.main.async {
        //                self.imagesCollectionView.reloadData()
        //            }
        //            KRProgressHUD.dismiss()
        //
        //        }
    }
    func issueDetails(){
       
        let userType = UserDefaults.standard.value(forKey: "user_type") as! String
        print(userType)
        let userId = UserDefaults.standard.value(forKey: "user_id")as! String
        switch userType {
        case "user":
            let postString = "user_id=\(userId)"
            postServiceData(serviceURL: Service.ISSUE_LIST, params: postString, type: UserIssueList.self) { (issuesList) in
                guard let issueData = issuesList.data else{return}
                KRProgressHUD.dismiss()
                let issueDetails = issueData[selectedIndex]
                guard let id = issueDetails.id else{return}
                UserDefaults.standard.set("\(id)", forKey: "id")
                    issueID = id           //send iissueId to chat Reply
                DispatchQueue.main.async {
                    self.issueIdLbl.text = issueDetails.issueId
                    self.issueCategoryLbl.text = "water"
                    self.issueTimeLbl.text = issueDetails.datetime
                    self.issueStatusLbl.text = issueDetails.workStatus?.rawValue
                    self.issueNameLbl.text = issueDetails.name
                    self.issueDescriptionTV.text = issueDetails.description
                }
            }
        case "executive":
            let postString = "executive_id=\(userId)"
            postServiceData(serviceURL: Service.ISSUE_LIST_EXECUTIVE, params: postString, type: ExecutiveList.self) { (issuesList) in
                guard let issueData = issuesList.data else{return}
                KRProgressHUD.dismiss()
                let issueDetails = issueData[selectedIndex]
                guard let id = issueDetails.id else{return}
                UserDefaults.standard.set("\(id)", forKey: "id")
                issueID = id               //send issueId to chat Reply
                DispatchQueue.main.async {
                    self.issueIdLbl.text = issueDetails.issueId
                    self.issueCategoryLbl.text = issueDetails.issueCategory?.rawValue
                    self.issueTimeLbl.text = issueDetails.datetime
                    self.issueStatusLbl.text = issueDetails.workStatus?.rawValue
                    self.issueNameLbl.text = issueDetails.name
                    self.issueDescriptionTV.text = issueDetails.description
                }
            }
            
        default:
            print("No data")
        }
        
    }
    
    
}

