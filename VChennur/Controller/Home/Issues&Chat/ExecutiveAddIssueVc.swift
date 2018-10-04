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
    
    var selectedTextField = UITextField()
    var categoryType = [String]()
    let picker = UIPickerView()
    var villageNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTV.delegate = self
        descriptionTV.text = "Type issue description.."
        descriptionTV.textColor = .lightGray
        
        categoryNamesAndVillagesServiceCalling()
    }
    
    func categoryNamesAndVillagesServiceCalling(){
        if categoryType.count == 0{
            categoryType.append("No Data")
        }
        getServiceData(serviceURL: Service.ISSUE_CATEGORY_LIST, type: CategoryList.self) { (category) in
            guard let categoryName = category.data else{return}
            for i in 0..<categoryName.count{
                self.categoryType.append(categoryName[i].name ?? "No Data")
            }
            self.categoryType.remove(at: 0)
            
        }
        getServiceData(serviceURL: Service.VILLAGE_NAMES_URL, type: Server.self) { (villages) in
            guard let village = villages.data else{return}
            for i in 0 ..< village.count{
                guard let name = village[i].name else {return}
                self.villageNames.append(name)
            }
            self.villageNames.remove(at: 0)
            print(self.villageNames)
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
            view.endEditing(true)
        }else if selectedTextField == selectCategoryTF  {
            selectCategoryTF.text = categoryType[row]
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
            
            let postString = "name=\(name)&user_phone=\(mobileNumber)&user_type=\(userType)&village_id=\(village)&issue_category=\(category)&user_name=\(userName)&description=\(description)&user_id=\(userId)"
            print(postString)
            postServiceData(serviceURL: Service.ADD_ISSUE, params: postString, type: AddIssue.self) { (addedIssue) in
                if let status = addedIssue.status, let message = addedIssue.message, let issueId = addedIssue.issueId{
                    if status == 1{
                        KRProgressHUD.showSuccess(withMessage: message + "Your ISSUE ID is\(issueId)")
                    }else{
                        print("not success")
                    }
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
