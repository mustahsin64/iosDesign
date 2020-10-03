//
//  APIManager.swift
//  designUI
//
//  Created by Siam on 9/26/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit
import Alamofire

let SIGNIN:String = "signIn"
let FORGET_PASSWORD:String = "Carrier/ForgetPassword"


protocol SignInAPIProtocol {
    func signInResponse(response:SignInFailedJson)
    func signInSuccess(response: signInSuccessJson)
    func forgetPassword(response: ForgetPasswordJson)
}

class AuthAPI: NSObject {
    
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
        let strEncoded:String = baseURL+SIGNIN
        
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
        
//        let request = AF.request(strEncoded,method: .post,parameters: params)
//        request.responseJSON { (data) in
//            print(data)
//        }
    }
    
    func mailMyPassword(to email:String)
    {
        let params = ["email":email.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)] as Dictionary<String, AnyObject>
        let strEncoded:String = baseURL+FORGET_PASSWORD
        
        if(debugAPILog){print("\(strEncoded) \(params)")}
        
        let request = AF.request(strEncoded,method: .post,parameters: params)
            .validate()
        request.responseDecodable(of: ForgetPasswordJson.self) { (response) in
            if let result = response.value{
                if(debugAPILog){print(result)}
                if let delegate = self.delegate{
                    delegate.forgetPassword(response: result)
                }
            }
            else
            {
                if(debugAPILog){print(response)}
            }
        }
    }

}

extension SignInAPIProtocol{
    func signInResponse(response:SignInFailedJson){
        
    }
    
    func signInSuccess(response: signInSuccessJson)
    {
        
    }
}
