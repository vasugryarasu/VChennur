////
////  ImagesUpload.swift
////  VChennur
////
////  Created by Vasu Yarasu on 24/09/18.
////  Copyright © 2018 iGrand. All rights reserved.
////
//
//import Foundation
//func createRequestBodyWith(parameters:[String:NSObject], filePathKey:String, boundary:String) -> NSData{
//    
//    let body = NSMutableData()
//    
//    for (key, value) in parameters {
//        body.appendString(string: "--\(boundary)\r\n")
//        body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//        body.appendString(string: "\(value)\r\n")
//    }
//    
//    body.appendString(string: "--\(boundary)\r\n")
//    
//    var mimetype = "image/jpg"
//    
//    let defFileName = "yourImageName.jpg"
//    
//    let imageData = UIImageJPEGRepresentation(yourImage, 1)
//    
//    body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(defFileName)\"\r\n")
//    body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
//    body.append(imageData!)
//    body.appendString(string: "\r\n")
//    
//    body.appendString(string: "--\(boundary)--\r\n")
//    
//    return body
//}
//
//
//
//func generateBoundaryString() -> String {
//    return "Boundary-\(NSUUID().uuidString)"
//}
//
//
//
//extension NSMutableData {
//    
//    func appendString(string: String) {
//        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
//        append(data!)
//}
//}
