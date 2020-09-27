//
//  ViewController.swift
//  designUI
//
//  Created by Siam on 9/25/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit


class SignInViewController: UIViewController {
    
    //MARK: IBLayouts
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var emailHolderView: UIView!
    @IBOutlet var passwordHolderView: UIView!
    
    //MARK: properties
    var signinLogic: SignInInteractor?

    
    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Router.shared.gotoMainTab(from: self)
    }
    
    //MARK: Internal methods
    
    private func customizeUI(){
        emailHolderView.giveGenericBorder()
        passwordHolderView.giveGenericBorder()
        
        emailField.delegate = self
        passwordField.delegate = self
        
        emailField.giveDefaultPlaceHolder(text: "Enter Email or Phone number")
        passwordField.giveDefaultPlaceHolder(text: "Enter password")
        
        
        testFillup()
    }
    
    private func testFillup(){
        self.emailField.text = "testsiam@test.com"
        self.passwordField.text = "narutosh129"
    }
    
    private func validateInput() -> Bool
    {
        if let email = self.emailField.text{
            if(email.isEmpty){
                return false
            }
        }
        
        if let password = self.passwordField.text{
            if(password.isEmpty){
                return false
            }
        }
        
        return true
    }
    
    //MARK: IBActions
    @IBAction func SignInClicked(_ sender: UIButton)
    {
        if(validateInput()){
            signinLogic = SignInInteractor.init(email: emailField.text!, password: passwordField.text!)
            signinLogic?.delegate = self
            signinLogic?.callSignInAPI()
        }
        else{
            self.showToastAtBottom(message: "All fields are required")
        }
    }
}

extension SignInViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return true
    }
}

extension SignInViewController: SignInLogicProtocol{
    func signInFailed(with errorMsg: String) {
        self.showToastAtBottom(message: errorMsg)
    }
    
    func signInSuccessful() {
        Router.shared.gotoMainTab(from: self)
    }
    
}






