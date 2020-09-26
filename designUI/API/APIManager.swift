//
//  APIManager.swift
//  designUI
//
//  Created by Siam on 9/26/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit
import Alamofire

protocol SignInAPIProtocol {
    func signInResponse(response:SignInJson)
}

class APIManager: NSObject {
    
    var delegate: SignInAPIProtocol? = nil
    
    class func testAlamofire(){
        let request = AF.request("https://swapi.dev/api/films")
            // 2
            request.responseJSON { (data) in
              print(data)
            }
    }
    
    func signIn(with email:String,and password:String){
        
        let params = ["os_info":UIDevice.current.systemVersion as AnyObject,"device":UIDevice.current.model as AnyObject,"email":email.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines),"password":"1234".trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)] as Dictionary<String, AnyObject>
        let strEncoded:String = baseURL+"signIn"
        
        print("\(strEncoded) \(params)")
        
        _ = AF.request(strEncoded,method: .post,parameters: params)
            .validate()
            .responseDecodable(of: SignInJson.self) { (response) in
                guard let result = response.value else {return}
                print(result)
                if let delegate = self.delegate{
                    delegate.signInResponse(response: result)
                }
            }
        
//        let request = AF.request(strEncoded,method: .post,parameters: params)
//        request.responseJSON { (data) in
//            print(data)
//        }
//
        
    }

}

extension SignInAPIProtocol{
    func signInResponse(response:SignInJson){
        
    }
}
