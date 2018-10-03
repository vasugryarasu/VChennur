//
//  Services.swift
//  VChennur
//
//  Created by Vasu Yarasu on 21/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import Foundation

// TESTING APIS
//enum Service{
//    static let BASE_URL = "http://igrand.info/vc/services/register/"
//    static let VILLAGE_NAMES_URL = BASE_URL + "village_list"
//    static let LOGIN_URL = BASE_URL + "login"
//    static let CHECK_OTP_URL = BASE_URL + "check_otp"
//
//    static let ISSUE_BASE_URL = "http://igrand.info/vc/services/issues/"
//    static let ISSUE_LIST = ISSUE_BASE_URL + "issue_list"
//    static let ADD_ISSUE = ISSUE_BASE_URL + "add_issue"
//    static let GET_ISSUE_CHAT = ISSUE_BASE_URL + "get_issue_chat"
//    static let ADD_ISSUE_CHAT = ISSUE_BASE_URL + "add_issue_chat"
//}

// LIVE APIS
enum Service{
    static let BASE_URL = "http://www.vchennur.com/zOD52A/services/register/"
    static let VILLAGE_NAMES_URL = BASE_URL + "village_list"
    static let LOGIN_URL = BASE_URL + "login"
    static let CHECK_OTP_URL = BASE_URL + "check_otp"
    static let FORGOT_PASSWORD = BASE_URL + "forget_passowrd"
    static let GENERAL_LOGIN = BASE_URL + "general_login"
    static let ISSUE_CATEGORY_LIST = BASE_URL + "issue_category_list"

    static let ISSUE_BASE_URL = "http://www.vchennur.com/zOD52A/services/issues/"
    static let ISSUE_LIST = ISSUE_BASE_URL + "issue_list"
    static let ISSUE_LIST_EXECUTIVE = ISSUE_BASE_URL + "issue_list_executive"
    static let ADD_ISSUE = ISSUE_BASE_URL + "add_issue"
    static let GET_ISSUE_IMAGES = ISSUE_BASE_URL + "get_issue_images"
    static let GET_ISSUE_CHAT = ISSUE_BASE_URL + "get_issue_chat"
    static let GET_EXECUTIVE_ISSUE_CHAT = ISSUE_BASE_URL + "get_executive_issue_chat"
    static let ADD_ISSUE_CHAT = ISSUE_BASE_URL + "add_issue_chat"
    static let GET_CHAT_ISSUE_IMAGES = ISSUE_BASE_URL + "get_chat_issue_images"
}





