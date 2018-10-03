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
class VCAddIssue: GenericVC,UITextViewDelegate {
    
    let imagePicker = BSImagePickerViewController()
    @IBOutlet weak var issueDescriptionTV: UITextView!
    @IBOutlet weak var issueNameTF: UITextField!
    @IBOutlet weak var selectCategoryTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        issueDescriptionTV.delegate = self
        issueDescriptionTV.text = "Type issue description.."
        issueDescriptionTV.textColor = UIColor.lightGray
        
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
                                                    DispatchQueue.main.async {
                                                        
                                                    }
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
        
    }
    
}

