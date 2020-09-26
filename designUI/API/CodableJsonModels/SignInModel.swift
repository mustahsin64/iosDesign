//
//  SignInModel.swift
//  designUI
//
//  Created by Siam on 9/26/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import Foundation

//struct signInSuccessJson: Decodable{
//    {
//        "area_id" : 6043,
//        "company_id" : 6044,
//        "currency_code": 840,
//        "currency_symbol" : "$",
//        "dispatcher_support_number" : "+1003300",
//        "email_address" : "testsiam@test.com",
//        "fixed_delivery_fee" : 0,
//        "id" : 16891,
//        "image_path" : "https://s3-us-west-2.amazonaws.com/qt.com.dashboard.profile.driver/3d9a2138bad04754a039c22b8c3caed0.jpg",
//        "name" : siamTest,
//        "routing" : 1,
//        "success" : true,
//        "thumbnail_image_path" : "https://s3-us-west-2.amazonaws.com/qt.com.dashboard.profile.driver/3d9a2138bad04754a039c22b8c3caed0.jpg",
//        "user_type" : carrier;
//    }
//}

struct signInSuccessJson: Codable {
    let areaID,companyID: String
    let currencyCode: Int
    let currencySymbol, dispatcherSupportNumber, emailAddress: String
    let fixedDeliveryFee: Int
    let id: String
    let imagePath: String
    let name: String
    let routing: Bool
    let success: String
    let thumbnailImagePath: String
    let userType: String

    enum CodingKeys: String, CodingKey {
        case areaID = "area_id"
        case companyID = "company_id"
        case currencyCode = "currency_code"
        case currencySymbol = "currency_symbol"
        case dispatcherSupportNumber = "dispatcher_support_number"
        case emailAddress = "email_address"
        case fixedDeliveryFee = "fixed_delivery_fee"
        case id
        case imagePath = "image_path"
        case name, routing, success
        case thumbnailImagePath = "thumbnail_image_path"
        case userType = "user_type"
    }
}

struct SignInFailedJson: Decodable {
  let response: String
  let success: String
  
}
