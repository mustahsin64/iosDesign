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
    @IBOutlet var wrongEmailLabel: UILabel!
    @IBOutlet var wrongPasswordLabel: UILabel!
    
    @IBOutlet var signInButton: UIButton!
    
    @IBOutlet var emailHolderView: UIView!
    @IBOutlet var passwordHolderView: UIView!
    
    //MARK: properties
    var signinLogic: SignInInteractor?
    var validEmail = false
    var validPassword = false

    
    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        //appearWrongInput(v: emailHolderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailField.becomeFirstResponder()
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
        
        
        //testFillup()
    }
    
    private func testFillup(){
        self.emailField.text = "testsiam@test.com"
        self.passwordField.text = "narutosh129"
    }
    
    //MARK: IBActions
    @IBAction func SignInClicked(_ sender: UIButton)
    {
        if(validEmail && validPassword){
            signinLogic = SignInInteractor.init(email: emailField.text!, password: passwordField.text!)
            signinLogic?.delegate = self
            signinLogic?.callSignInAPI()
        }
        else{
            self.showToastAtBottom(message: "All fields are required")
        }
    }
    
    
    @IBAction func emailEditingChanged(_ sender: UITextField) {
        colorizeFiledsAccordingToValidity(currentText: sender.text ?? "", textField: emailField)
    }
    
    @IBAction func passwordEditingChanged(_ sender: UITextField) {
        colorizeFiledsAccordingToValidity(currentText: sender.text ?? "", textField: passwordField)
    }
    
    //MARK:validation
    
    private func validateEmail(text:String) -> Bool
    {
        var validation = true
        if(!text.isValidEmail(text))
        {
            validation = false
        }
        return validation
    }
    
    private func validatePassword(text:String) -> Bool
    {
        var validation = true
        if(text.count < 10){
            validation = false
        }
        return validation
    }
    
    private func hideWithAnimation(hide:Bool, label:UILabel)
    {
        if(hide)
        {
            UIView.transition(with: label, duration: 0.2,
                              options: .transitionCrossDissolve,
                              animations: {
                                label.isHidden = hide
                          })
        }
        else{
            UIView.transition(with: label, duration: 0.2,
                              options: .curveEaseIn,
                              animations: {
                                label.isHidden = hide
                          })
        }
    }
    
    private func colorizeFiledsAccordingToValidity(currentText:String,textField:UITextField)
    {
        if(textField == emailField){
            if(self.validateEmail(text: currentText))
            {
                validEmail = true
                hideWithAnimation(hide: true, label: wrongEmailLabel)
                //wrongEmailLabel.isHidden = true
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                    self.appearCorrectInput(v: self.emailHolderView)
                }
            }
            else
            {
                validEmail = false
                hideWithAnimation(hide: false, label: wrongEmailLabel)
                //wrongEmailLabel.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                    self.appearWrongInput(v: self.emailHolderView)
                }
            }
        }
        else if(textField == passwordField){
            
            if(self.validatePassword(text: currentText))
            {
                validPassword = true
                hideWithAnimation(hide: true, label: wrongPasswordLabel)
                //wrongPasswordLabel.isHidden = true
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                    self.appearCorrectInput(v: self.passwordHolderView)
                }
            }
            else
            {
                validPassword = false
                hideWithAnimation(hide: false, label: wrongPasswordLabel)
                //wrongPasswordLabel.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                    self.appearWrongInput(v: self.passwordHolderView)
                }
            }
        }
        
        if(validEmail && validPassword)
        {
            self.signInButton.backgroundColor = UIColor(named: "correctInput")
        }
        else
        {
            self.signInButton.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        }
    }
    
    private func validateInput() -> Bool
    {
        return true
    }
    
    private func appearWrongInput(v:UIView)
    {
        v.setBorderColor(color: .red)
        v.backgroundColor = UIColor.init(named: "inputError")
        v.removeBottomShadow()
    }
    
    private func appearCorrectInput(v:UIView)
    {
        v.setBorderColor(color: UIColor.init(named: "correctInput") ?? .green)
        v.backgroundColor = .clear
        v.addBottomShadow()
    }
}



extension SignInViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
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






