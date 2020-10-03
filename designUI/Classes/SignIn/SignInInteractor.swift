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
    
    func mailMyPasswordSuccess(with msg:String)
    func mailMyPasswordFailed(with msg:String)
}

class SignInInteractor: NSObject {
    
    let apimanager = AuthAPI()
    var delegate: SignInLogicProtocol?
    
    var email:String = ""
    var password:String = ""
    var forgetPasswordMail:String?
    
    init(email:String,password:String){
        self.email = email
        self.password = password
    }
    
    init(forgetPasswordMail:String)
    {
        self.forgetPasswordMail = forgetPasswordMail
    }
    
    func callSignInAPI(){
        validateParameters()
        apimanager.delegate = self
        apimanager.signIn(with: email, and: password)
    }
    
    func callForgetPasswordAPI()
    {
        validateForgetPassWordMail()
        apimanager.delegate = self
        apimanager.mailMyPassword(to: forgetPasswordMail!)
    }
    
    func validateParameters(){
        email = email.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        password = password.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    func validateForgetPassWordMail()
    {
        if var forgetPasswordMail = self.forgetPasswordMail{
            forgetPasswordMail = forgetPasswordMail.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        }
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
    
    func forgetPassword(response: ForgetPasswordJson) {
        if (response.success == true)
        {
            if let delegate = self.delegate{
                delegate.mailMyPasswordSuccess(with: response.response ?? "Successfully mail sent")
            }
        }
        else{
            if let delegate = self.delegate{
                delegate.mailMyPasswordFailed(with: response.response ?? "Failed to send mail")
            }
        }
        
    }
}
