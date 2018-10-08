//
//  VCIssueDetailVC.swift
//  VChennur
//
//  Created by Vasu Yarasu on 28/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit
import KRProgressHUD

class VCIssueDetailVC: GenericVC ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var imageData: [URL] = []
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var issueIdLbl: UILabel!
    @IBOutlet weak var issueCategoryLbl: UILabel!
    @IBOutlet weak var issueTimeLbl: UILabel!
    @IBOutlet weak var issueStatusLbl: UILabel!
    @IBOutlet weak var issueNameLbl: UILabel!
    @IBOutlet weak var issueDescriptionTV: UITextView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var issuesImagesCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        issueDetails()

    }
    
    func issueDetails(){
        
        let userType = UserDefaults.standard.value(forKey: "user_type") as! String
        //        print(userType)
        let userId = UserDefaults.standard.value(forKey: "user_id")as! String
        switch userType {
        case "user":
            let postString = "user_id=\(userId)"
            postServiceData(serviceURL: Service.ISSUE_LIST, params: postString, type: UserIssueList.self) { (issuesList) in
                guard let status = issuesList.status, let message = issuesList.message else{return}
                if status == 1{
                    KRProgressHUD.dismiss()
                    guard let issueData = issuesList.data else{return}
                    let issueDetails = issueData[selectedIndex]
                    guard let id = issueDetails.id else{return}
                    UserDefaults.standard.set("\(id)", forKey: "id")
                    self.getImages(issueIDForImages: id)
                    DispatchQueue.main.async {
                        self.issueIdLbl.text = issueDetails.issueId
                        self.issueCategoryLbl.text = issueDetails.issueCategory?.rawValue
                        self.issueTimeLbl.text = issueDetails.datetime
                        self.issueStatusLbl.text = issueDetails.workStatus?.rawValue
                        self.issueNameLbl.text = issueDetails.name
                        self.issueDescriptionTV.text = issueDetails.description
                    }
                }else{KRProgressHUD.showMessage(message)}
                
            }
        case "executive":
            let postString = "executive_id=\(userId)"
            postServiceData(serviceURL: Service.ISSUE_LIST_EXECUTIVE, params: postString, type: UserIssueList.self) { (issuesList) in
                guard let status = issuesList.status, let message = issuesList.message else{return}
                if status == 1{
//                    KRProgressHUD.dismiss()
                    guard let issueData = issuesList.data else{return}
                    let issueDetails = issueData[selectedIndex]
                    guard let id = issueDetails.id else{return}
                    UserDefaults.standard.set("\(id)", forKey: "id")
                    self.getImages(issueIDForImages: id)
                    DispatchQueue.main.async {
                        self.issueIdLbl.text = issueDetails.issueId
                        self.issueCategoryLbl.text = issueDetails.issueCategory?.rawValue
                        self.issueTimeLbl.text = issueDetails.datetime
                        self.issueStatusLbl.text = issueDetails.workStatus?.rawValue
                        self.issueNameLbl.text = issueDetails.name
                        self.issueDescriptionTV.text = issueDetails.description
                    }
                }else{KRProgressHUD.showMessage(message)}
            }
        default:
            print("No data")
        }
    }
    func getImages(issueIDForImages: String){
        
        let postString = "issue_id=\(issueIDForImages)"
        print(postString)
        postServiceData(serviceURL: Service.GET_ISSUE_IMAGES, params: postString, type: GetImages.self) { (getImages) in
            guard let status = getImages.status, let message = getImages.message else{return}
            if status == 1{
                KRProgressHUD.dismiss()
                guard let images = getImages.data else{return}
                for i in 0..<images.count{
                    guard let url = URL(string:images[i].image!)else{return}
                    self.imageData.append(url)
                    DispatchQueue.main.async{
                        self.issuesImagesCV.reloadData()
                    }
                }
            }else{KRProgressHUD.showMessage(message)}
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "issueImagesCell", for: indexPath) as! IssueImageCell
        URLSession.shared.dataTask(with: imageData[indexPath.row]) { (data, response, error) in
            if let e = error {
                print("Error Occurred: \(e)")
            } else {
                if (response as? HTTPURLResponse) != nil {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            cell.issueImage.image = image
                        }

                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
            }
            }.resume()

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

