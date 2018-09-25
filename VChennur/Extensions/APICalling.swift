//
//  APICalling.swift
//  VChennur
//
//  Created by Vasu Yarasu on 24/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{

    //GET METHOD
func getServiceData <T : Decodable> (serviceURL: String,type: T.Type,completionHandler:@escaping (_ details: T) -> Void){        guard let url = URL(string: serviceURL) else{return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data else{return}
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let model = try decoder.decode(type, from: dataResponse)
                completionHandler(model)
            }catch let error{
                print(error)
            }
            }.resume()
    }
//POST METHOD

    func postServiceData <T : Decodable> (serviceURL: String,params: String,type: T.Type,completionHandler:@escaping (_ details: T) -> Void){
        let url = URL(string: serviceURL)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = params.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let dataResponse = data,error == nil else{
                print(error?.localizedDescription ?? "response Error")
                return }
            do{
                let  decoder = JSONDecoder()
                let model = try decoder.decode(type, from: dataResponse)
                completionHandler(model)
            }catch let parsingError{
                print("Error:",parsingError)
            }
            }.resume()
    }
    

}
