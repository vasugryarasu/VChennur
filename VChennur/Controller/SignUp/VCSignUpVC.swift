//
//  VCSignUpVC.swift
//  VNetha
//
//  Created by Vasu Yarasu on 19/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import UIKit
import KRProgressHUD

var registeredOTP: Int?
class VCSignUpVC: GenericVC{

// MARK:- Create Properties
    let picker = UIPickerView()
    let imagePicker = UIImagePickerController()
    var imageName = String()
    var villageNames = [String]()

// MARK:- Create IBOutlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var selectVillageTF: TextField!
    @IBOutlet weak var nameTF: TextField!
    @IBOutlet weak var mobileNumberTF: TextField!
    @IBOutlet weak var passwordTF: TextField!
    @IBOutlet weak var reTypePasswordTF: TextField!
    
// MARK:- View DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.dataSource = self
        picker.delegate = self
        imagePicker.delegate = self
        reTypePasswordTF.delegate = self
        selectVillageTF.delegate = self
        selectVillageTF.inputView = picker
    }
    override func viewWillAppear(_ animated: Bool) {
       
// MARK:- Village Names Service Calls
        if self.villageNames.count == 0{
            self.villageNames.insert(" ", at: 0)
        }
        getServiceData(serviceURL: Service.VILLAGE_NAMES_URL, type: Server.self) { (villages) in
            guard let village = villages.data else{return}
            for i in 0 ..< village.count{
                guard let name = village[i].name else {return}
                self.villageNames.append(name)
            }
            self.villageNames.remove(at: 0)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
// MARK:- Update UI
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
// MARK:- IBActions
// Select pictures from local paths
    @IBAction func chooseImage(_ sender: UIButton) {
     didTapChooseBtn()
    }
    @IBAction func signUpBtn(_ sender: UIButton) {
        validateAndUploadUserData()
    }
    func validateAndUploadUserData(){

        guard let phone = mobileNumberTF.text, let village = selectVillageTF.text, let name = nameTF.text, let password = passwordTF.text, let reTypePassword = reTypePasswordTF.text else{return}
        let isvalid = mobileNumberValidate(value: phone)
        if isvalid && village.count != 0 && name.count != 0 && password == reTypePassword {
            imageUploadRequest()
        }else{
            alert(title: "Invalid Details", message: "Please check your details before signUp", actions: UIAlertAction(title: "OK", style: .default, handler: nil))
        }
    }
    func imageUploadRequest()
    {
        guard let phone = mobileNumberTF.text, let village = selectVillageTF.text, let name = nameTF.text, let password = passwordTF.text else{return}

        guard let myUrl = URL(string: Service.BASE_URL)else{return}
        let request = NSMutableURLRequest(url:myUrl);
        request.httpMethod = "POST";
        
        let param : [String: String] = [
            "village_id"   : village,
            "phone"        : phone,
            "name"         : name,
            "password"     : password,
        ]
        
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let imagData = resizeImage(image: profileImage.image!).jpegData(compressionQuality: 0.2)
        if imagData == nil{ return }
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imagData! as NSData, boundary: boundary) as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                guard let serverResponse = json else{return}
                print(serverResponse)
                let status = serverResponse["status"] as! Int
                let message = serverResponse["message"] as! String
                
                DispatchQueue.main.async {
                    if status == 0{
                        KRProgressHUD.showMessage(message)
                    }else{
                        let otp = serverResponse["otp"] as! Int
                        registeredOTP = otp
                        KRProgressHUD.showSuccess(withMessage: message)
                        self.navigateToDestinationThrough(storyboardID: StoryboardId.ENTER_OTP)
                    }
                }
            }catch
            {
                print(error)
            }
        }
        task.resume()
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData()
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        //        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"image\"; filename=\"\(imageName)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString("\r\n")
        body.appendString("--\(boundary)--\r\n")
        return body
    }
    
    func resizeImage(image: UIImage) -> UIImage
    {
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        let maxHeight: Float = 300.0
        let maxWidth: Float = 400.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.5
        //50 percent compression
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        
        let rect = CGRect(x: 0.0, y: 0.0,width: CGFloat(actualWidth),height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img!.jpegData(compressionQuality: CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!)!
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
}
extension NSMutableData {
    
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
extension VCSignUpVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
// When tap on the choose button action-sheet will call
    func didTapChooseBtn(){
        actionSheet(title: "Profile picture", message: "Please select your profile picture", actions:
//            UIAlertAction(title: "Camera", style: .default, handler: { _ in
//            self.openCamera()}),
                    UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                        self.openGallary()}),
                    UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    }
//  Tap on the Open camera
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            alert(title: "Warning", message: "You don't have camera")
        }
    }
// Tap on the Open Gallary
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
// MARK:- Grab the Images path from the Device path
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        if let pickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage{
            print(pickedImage)
            profileImage.image = pickedImage
            profileImage.contentMode = .scaleAspectFill
            
        }
        let imagePath: NSURL = (info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.referenceURL)] as! NSURL)
        imageName = imagePath.lastPathComponent!
        print(imageName)
        
        self.dismiss(animated: true, completion: nil)
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
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
