//
//  ExecutiveAddIssueVc.swift
//  VChennur
//
//  Created by Vasu Yarasu on 29/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit
import KRProgressHUD

class ExecutiveAddIssueVc: GenericVC,UIPickerViewDataSource,UIPickerViewDelegate {
    @IBOutlet weak var issueNameTF: UITextField!
    @IBOutlet weak var selectVillageTF: UITextField!
    @IBOutlet weak var selectCategoryTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    
    var categoryType = [String]()
    var categoryID = [String]()
    var pickedCategoryType = String()

    var villageNames = [String]()
    var villageID = [String]()
    var pickedVillageID = String()
    
    let picker = UIPickerView()
    var selectedTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTV.delegate = self
        descriptionTV.text = "Type issue description.."
        descriptionTV.textColor = .lightGray
        
        categoryNamesAndVillagesServiceCalling()
    }
    
    func categoryNamesAndVillagesServiceCalling(){
        if categoryType.count == 0{
            picker.isHidden = true
        }
        getServiceData(serviceURL: Service.VILLAGE_NAMES_URL, type: Villages.self) { (village) in
            guard let status = village.status, let message = village.message else{return}
            if status == 1{
                guard let villageData = village.data else{return}
                self.villageNames = villageData.compactMap({$0["name"]})
                self.villageID = villageData.compactMap({$0["id"]})
                //                self.picker.isHidden = false
                
            }else{
                KRProgressHUD.showMessage(message)
            }
        }
        
        getServiceData(serviceURL: Service.ISSUE_CATEGORY_LIST, type: CategoryList.self) { (category) in
            guard let status = category.status, let message = category.message else{return}
            if status == 1{
                guard let categoryData = category.data else{return}
                self.categoryType = categoryData.map({$0.name!})
                self.categoryID = categoryData.map({$0.id!})
                DispatchQueue.main.async {
                    self.picker.isHidden = false
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
        if selectedTextField == selectVillageTF{
            return villageNames.count
        }else if selectedTextField == selectCategoryTF{
            return categoryType.count
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if selectedTextField == selectVillageTF{
            return villageNames[row]
        }else if selectedTextField == selectCategoryTF{
            return categoryType[row]
        }else{
            return "No data"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if selectedTextField == selectVillageTF{
            selectVillageTF.text = villageNames[row]
            pickedVillageID = villageID[pickerView.selectedRow(inComponent: 0)]
            view.endEditing(true)
        }else if selectedTextField == selectCategoryTF  {
            selectCategoryTF.text = categoryType[row]
            pickedCategoryType = categoryID[pickerView.selectedRow(inComponent: 0)]
            view.endEditing(true)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextField = textField
        picker.delegate = self
        picker.dataSource = self
        if selectedTextField == selectVillageTF{
            selectVillageTF.inputView = picker
        }else if selectedTextField == selectCategoryTF{
            selectCategoryTF.inputView = picker
        }
    }
    
    
    @IBAction func addFiles(_ sender: UIButton) {
    }
    @IBAction func onSubmitBtnTapped(_ sender: UIButton) {
        
        let userType = UserDefaults.standard.value(forKey: "user_type")as! String
        let userId = UserDefaults.standard.value(forKey: "user_id") as! String
        let phone = mobileNumberValidate(value: mobileNumberTF.text!)
        
        guard let name = issueNameTF.text,
            let village = selectVillageTF.text,
            let category = selectCategoryTF.text,
            let userName = userNameTF.text,
            let description = descriptionTV.text,
            let mobileNumber = mobileNumberTF.text else{return}
        
        if village.count >= 1 && category.count >= 1 && phone && description.count >= 1 && name.count >= 2 && phone == true {
            
            let postString = "name=\(name)&user_phone=\(mobileNumber)&user_type=\(userType)&village_id=\(pickedVillageID)&issue_category=\(pickedCategoryType)&user_name=\(userName)&description=\(description)&executive_id=\(userId)"
//                       print(postString)
            postServiceData(serviceURL: Service.ADD_ISSUE, params: postString, type: AddIssue.self) { (addedIssue) in
                guard let status = addedIssue.status, let message = addedIssue.message else{return}
                if status == 1{
                    KRProgressHUD.showSuccess(withMessage: message)
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                }else{
                    KRProgressHUD.showMessage(message)
                }
            }
        }else{
            KRProgressHUD.showWarning(withMessage: "Invalid Details Please Check before submit")
        }
    }
}
extension ExecutiveAddIssueVc: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTV.textColor == UIColor.lightGray {
            descriptionTV.text = nil
            descriptionTV.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type issue description.."
            textView.textColor = UIColor.lightGray
        }
    }
    
}
