//
//  SignInInteractor.swift
//  designUI
//
//  Created by Siam on 9/26/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit

protocol SignInLogicProtocol {
    func signInSuccessful()
    func signInFailed(with errorMsg:String)
}

class SignInInteractor: NSObject {
    
    let apimanager = APIManager()
    var delegate: SignInLogicProtocol?
    
    var email:String = ""
    var password:String = ""
    
    init(email:String,password:String){
        self.email = email
        self.password = password
    }
    
    func callSignInAPI(){
        validateParameters()
        apimanager.delegate = self
        apimanager.signIn(with: email, and: password)
    }
    
    func validateParameters(){
        email = email.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        password = password.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
}

extension SignInInteractor: SignInAPIProtocol{
    
    func signInSuccess(response: signInSuccessJson) {
        if let delegate = self.delegate{
            delegate.signInSuccessful()
        }
    }
    
    func signInResponse(response: SignInFailedJson) {
        print(response.response)
        print(response.success)
        
        if(response.success == "false"){
            if let delegate = self.delegate{
                delegate.signInFailed(with: response.response)
            }
        }
    }
    
}
