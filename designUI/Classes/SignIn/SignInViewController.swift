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
        //appearWrongInput(v: emailHolderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Router.shared.gotoMainTab(from: self)
    }
    
    //MARK: Internal methods
    
    private func customizeUI(){
        emailHolderView.giveGenericBorder()
        passwordHolderView.giveGenericBorder()
        
        emailHolderView.giveRoundedCorner(value: 5)
        passwordHolderView.giveRoundedCorner(value: 5)
        
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
        var validation = true
        if let email = self.emailField.text{
            if(email.isEmpty){
                appearWrongInput(v: emailHolderView)
                validation = false
                //return false
            }
            else{
                appearCorrectInput(v: emailHolderView)
            }
        }
        
        if let password = self.passwordField.text{
            if(password.isEmpty){
                appearWrongInput(v: passwordHolderView)
                validation = false
            }
            else{
                appearCorrectInput(v: passwordHolderView)
            }
        }
        
        return validation
    }
    
    private func appearWrongInput(v:UIView)
    {
        v.setBorderColor(color: .red)
        v.backgroundColor = UIColor.init(named: "inputError")
    }
    
    private func appearCorrectInput(v:UIView)
    {
        v.setBorderColor(color: UIColor.init(named: "correctInput") ?? .green)
        v.backgroundColor = .clear
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






