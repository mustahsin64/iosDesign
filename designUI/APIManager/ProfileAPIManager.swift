//
//  APIManager.swift
//  designUI
//
//  Created by Siam on 9/26/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit
import Alamofire

let debugAPILog:Bool = true

protocol SignInAPIProtocol {
    func signInResponse(response:SignInFailedJson)
    func signInSuccess(response: signInSuccessJson)
}

class ProfileAPIManager: NSObject {
    
    var delegate: SignInAPIProtocol? = nil
    
    class func testAlamofire(){
        let request = AF.request("https://swapi.dev/api/films")
            // 2
            request.responseJSON { (data) in
              print(data)
            }
    }
    
    func signIn(with email:String,and password:String){
        
        let params = ["os_info":UIDevice.current.systemVersion as AnyObject,"device":UIDevice.current.model as AnyObject,"email":email.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines),"password":password.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)] as Dictionary<String, AnyObject>
        let strEncoded:String = baseURL+"signIn"
        
        if(debugAPILog){print("\(strEncoded) \(params)")}
        
        
        
        let request = AF.request(strEncoded,method: .post,parameters: params)
            .validate()
        request.responseDecodable(of: signInSuccessJson.self) { (response) in
            if let result = response.value{
                // signIn successful response
                if(debugAPILog){print(result)}
                if let delegate = self.delegate{
                    delegate.signInSuccess(response: result)
                }
            }
            else{
                request.responseDecodable(of: SignInFailedJson.self) { (response) in
                    if let result = response.value {
                        // signIn failed response
                        if let delegate = self.delegate{
                            delegate.signInResponse(response: result)
                        }
                    }
                    else{
                        if let delegate = self.delegate{
                            let error = SignInFailedJson.init(response: "Failed", success: "false")
                            delegate.signInResponse(response: error)
                        }
                    }
                }
            }
            
        }
        
//        var request = AF.request(strEncoded,method: .post,parameters: params)
//            .validate()
//            .responseDecodable(of: SignInJson.self) { (response) in
//                guard let result = response.value else
//                {
//                    return
//
//                }
//                print(result)
//                if let delegate = self.delegate{
//                    delegate.signInResponse(response: result)
//                }
//            }
        
//        let request = AF.request(strEncoded,method: .post,parameters: params)
//        request.responseJSON { (data) in
//            print(data)
//        }
    }

}

extension SignInAPIProtocol{
    func signInResponse(response:SignInFailedJson){
        
    }
    
    func signInSuccess(response: signInSuccessJson)
    {
        
    }
}
