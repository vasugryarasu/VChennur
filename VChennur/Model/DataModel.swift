//
//  DataModel.swift
//  VChennur
//
//  Created by Vasu Yarasu on 21/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import Foundation

//Village
struct Villages: Codable {
    let status: Int?
    let message: String?
    let data: [[String: String]]?
}
//General Login post data
struct Login:Codable{
    let phone: String
    let password: String
}
//General login get data
struct GeneralLogin: Codable {
    let status: Int?
    let message, userType: String?
    let data: DataClass?
}
struct DataClass: Codable {
    let userId, firstName, lastName, phone: String?
    let email, villageId, villageName: String?
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
struct ForgotPassword: Codable {
    let status: Int
    let message: String
}
struct Register: Codable {
    let status, loginType, otp: Int?
    let message: String?
}

//User Issue List
struct UserIssueList: Codable {
    let status: Int?
    let message: String?
    let data: [IssuesData]?
}
struct IssuesData: Codable {
    let id, issueId, userId, name: String?
    let description, datetime: String?
    let issueCategory : CategoryType?
    let workStatus: StatusOfWork?
    let status: String?
    
}
enum CategoryType: String, Codable {
    case empty = ""
    case power = "power"
    case water = "water"
}
enum StatusOfWork: String, Codable {
    case pending = "Pending"
    case processing = "Processing"
    case workStatusOpen = "Open"
}

//Get images
struct GetImages: Codable {
    let status: Int?
    let message: String?
    let data: [IssueImages]?
}

struct IssueImages: Codable {
    let id, issueId: String?
    let image: String?
    
}
// Category List
struct CategoryList: Codable {
    let status: Int?
    let message: String?
    let data: [CategoryName]?
}
//CategoryName
struct CategoryName: Codable {
    let id, name, description, status: String?
}


//Executive Issue Chat
struct ExecutiveIssueChat: Codable {
    let status: Int?
    let message: String?
    let data: [ChatData]?

}
struct ChatData: Codable {
    let id, issueId, userId: String?
    let descriptionType: Int?
    let description, datetime: String?
    let userType: UserType?
    let images: [Image]?
    let imageType: Int?
}
struct Image: Codable {
    let id, issueId: String?
    let image: String?
}
enum UserType: String, Codable {
    case admin = "admin"
    case user = "user"
}
// Add Issue
struct AddIssue: Codable {
    let status: Int?
    let message: String?
    let issueId: Int?

    enum CodingKeys: String, CodingKey {
        case status, message
        case issueId = "issue_id"
    }
}
// Reply Chat

struct Chatreply: Codable {
    let status: Int?
    let message: String?
    let chatIssueId: Int?
}





