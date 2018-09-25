//
//  DataModel.swift
//  VChennur
//
//  Created by Vasu Yarasu on 21/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import Foundation

//Village
struct Server: Decodable {
    let status: Int?
    let message: String?
    let data: [Village]?
}
struct Village: Decodable{
    let name: String?
}
//General Login post data
struct Login:Encodable{
    let phone: String
    let password: String
}
//General login get data
struct GeneralLogin: Decodable {
    let status: Int?
    let message, userType: String?
    let data: DataClass?
}
struct DataClass: Decodable {
    let userID, firstName, lastName, phone: String?
    let email, villageID, villageName: String?
    let image: String?
    let gender, address: String?
}
//OTP Model
struct Otp: Codable {
    let status, otp, loginType: Int?
    let message, userType: String?
    let data: OtpData?
}

struct OtpData: Codable {
    let userID, firstName, lastName, phone: String?
    let email, villageID, villageName: String?
    let image: String?
    let gender, address: String?
}
// Forgot Password
struct ForgotPassword: Decodable {
    let status: Int
    let message: String
}
