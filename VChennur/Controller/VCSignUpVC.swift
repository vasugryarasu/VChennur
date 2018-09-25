//
//  VCSignUpVC.swift
//  VNetha
//
//  Created by Vasu Yarasu on 19/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit

var villageNames = [String]()
var photoURL: URL?
class VCSignUpVC: UIViewController,UITextFieldDelegate{

// MARK:- Create Properties
    let picker = UIPickerView()
    let imagePicker = UIImagePickerController()
    
// MARK:- Create IBOutlets
    @IBOutlet weak var selectVillageTF: TextField!
    @IBOutlet weak var nameTF: TextField!
    @IBOutlet weak var mobileNumberTF: TextField!
    @IBOutlet weak var passwordTF: TextField!
    @IBOutlet weak var reTypePasswordTF: TextField!
    @IBOutlet weak var image: UIImageView!
    
// MARK:- View DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
        imagePicker.delegate = self
        selectVillageTF.inputView = picker
// MARK:- Village Names Service Calls
        getServiceData(serviceURL: Service.VILLAGE_NAMES_URL, type: Server.self) { (villages) in
            guard let village = villages.data else{return}
            for i in 0 ..< village.count{
                guard let name = village[i].name else {return}
                villageNames.append(name)
            }
        }
    }
// MARK:- Update UI
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isNavigationHide(bool: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
// MARK:- IBActions
// Select pictures from local paths
    @IBAction func chooseImage(_ sender: UIButton) {
     didTapChooseBtn()
    }
    @IBAction func signUpBtn(_ sender: UIButton) {
    }
//    func validation(){
//    
//        guard let phone = mobileNumberTF.text, let village = selectVillageTF.text, let name = nameTF.text, let password = passwordTF.text, let image =  else{return}
//        
//        let isvalid = mobielNumberValidate(value: phone)
//        let postString = "village_id=\(selectVillageTF.text)"
//        if isvalid && selectVillageTF.text?.count != 0 && nameTF.text?.count != 0 && passwordTF.text == reTypePasswordTF.text {
//            print("sucessfully registered")
////            postServiceData(serviceURL: <#T##String#>, params: <#T##String#>, type: <#T##Decodable.Protocol#>, completionHandler: <#T##(Decodable) -> Void#>)
//            navigationController?.popToRootViewController(animated: true)
//        }else{
//            alert(title: "Invalid details", message: "pleasefi")
//        }
//    }
}

extension VCSignUpVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
// When tap on the choose button action-sheet will call
    func didTapChooseBtn(){
        actionSheet(title: "Choose Image", message: "Please select photo", actions: UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()}),
                    UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                        self.openGallary()}),
                    UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    }
//  Tap on the Open camera
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            alert(title: "Warning", message: "You don't have camera")
        }
    }
// Tap on the Open Gallary
    func openGallary(){
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
// MARK:- Grab the Images path from the Device path
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imgUrl = info[UIImagePickerControllerImageURL] as? URL{
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            let data = UIImagePNGRepresentation(image)! as NSData
            data.write(toFile: localPath!, atomically: true)
            photoURL = URL(fileURLWithPath: localPath!)
        }
        dismiss(animated: true, completion: nil)
    }
}
// MARK:- PickerView delegates,Data source
extension VCSignUpVC: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return villageNames.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(villageNames[row])"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectVillageTF.text = "\(villageNames[row])"
        selectVillageTF.resignFirstResponder()
    }
}
