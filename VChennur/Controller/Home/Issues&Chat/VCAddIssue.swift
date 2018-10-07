//
//  VCAddIsseVC.swift
//  VChennur
//
//  Created by Vasu Yarasu on 28/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit
import BSImagePicker
import PhotosUI
import KRProgressHUD

class VCAddIssue: GenericVC,UITextViewDelegate {
    
    let imagePicker = BSImagePickerViewController()
    var categoryType = [String]()
    var categoryID = [String]()
    let categoryPicker = UIPickerView()
    var pickedCategory: String?
    
    @IBOutlet weak var issueDescriptionTV: UITextView!
    @IBOutlet weak var issueNameTF: UITextField!
    @IBOutlet weak var selectCategoryTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        issueDescriptionTV.delegate = self
        issueDescriptionTV.text = "Type issue description.."
        issueDescriptionTV.textColor = UIColor.lightGray
        categoryPicker.delegate = self
        
        selectCategoryTF.inputView = categoryPicker
        getIssueCategory()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if issueDescriptionTV.textColor == UIColor.lightGray {
            issueDescriptionTV.text = nil
            issueDescriptionTV.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type issue description.."
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func tappedOnAddFiles(_ sender: UIButton) {
        multipleImagePickerController()
    }
    func multipleImagePickerController(){
        
        bs_presentImagePickerController(imagePicker, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            let manager = PHImageManager.default()
                                            let options = PHImageRequestOptions()
                                            options.version = .original
                                            options.isSynchronous = true
                                            manager.requestImageData(for: asset, options: options, resultHandler: { (data, _, _, _) in
                                                if data != nil{
                                                    
                                                }
                                            })
                                            
                                            
        }, deselect: { (asset: PHAsset) -> Void in
            // User deselected an assets.
            // Do something, cancel upload?
        }, cancel: { (assets: [PHAsset]) -> Void in
            
        }, finish: { (assets: [PHAsset]) -> Void in
            
        }, completion: nil)
    }
    
    @IBAction func tappedOnSubmitBtn(_ sender: UIButton) {
        userAddIssue()
    }
    
    func userAddIssue(){
        guard let issueName = issueNameTF.text,
            let category = selectCategoryTF.text,
            let description = issueDescriptionTV.text,
            let pickedValue = pickedCategory,
            
            let userPhone = UserDefaults.standard.value(forKey: "phone"),
            let userType = UserDefaults.standard.value(forKey: "user_type"),
            let userId = UserDefaults.standard.value(forKey: "user_id"),
            let village = UserDefaults.standard.value(forKey: "village_id"),
            let userName = UserDefaults.standard.value(forKey: "first_name") else{return}
        
        if category.count >= 1 && description.count >= 1 && issueName.count >= 1 {
            
            let postString = "name=\(issueName)&user_phone=\(userPhone)&user_type=\(userType)&village_id=\(village)&issue_category=\(pickedValue)&user_name=\(userName)&description=\(description)&user_id=\(userId)"
            print(postString)
            postServiceData(serviceURL: Service.ADD_ISSUE, params: postString, type: AddIssue.self) { (addedIssue) in
                guard let status = addedIssue.status,let message = addedIssue.message else{return}
                print(status)
                if status == 1{
                    KRProgressHUD.showSuccess(withMessage: message)
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }else{
            KRProgressHUD.showWarning(withMessage: "Invalid Details Please Check before submit")
        }
    }
}
extension VCAddIssue: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func getIssueCategory(){
        if categoryType.count == 0{
            categoryPicker.isHidden = true
        }
        getServiceData(serviceURL: Service.ISSUE_CATEGORY_LIST, type: CategoryList.self) { (category) in
            guard let status = category.status, let message = category.message else{return}
            if status == 1{
                guard let categoryData = category.data else{return}
                self.categoryType = categoryData.map({$0 .name!})
                self.categoryID = categoryData.map({$0.id!})
                DispatchQueue.main.async {
                    self.categoryPicker.isHidden = false
                }
            }else{
                KRProgressHUD.showMessage(message)
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryType.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryType[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectCategoryTF.text = categoryType[row]
        pickedCategory = categoryID[pickerView.selectedRow(inComponent: 0)]
    }
    
    
}
