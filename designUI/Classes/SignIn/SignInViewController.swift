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
    @IBOutlet var forgotPasswordTextView: UITextView!
    @IBOutlet var signInButton: UIButton!
    
    @IBOutlet var emailHolderView: UIView!
    @IBOutlet var passwordHolderView: UIView!
    
    //MARK: properties
    var signinLogic: SignInInteractor?
    var validEmail = false
    var validPassword = false
    var validEmailForPasswordRecovery = false
    var forgetPasswordMail:String?
    
    var passwordRecoveryView : PasswordRecoveryView?
    var transparentButton : UIButton?

    
    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
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
        signInButton.giveRoundedCorner(value: 5)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        emailField.giveDefaultPlaceHolder(text: "Enter Email or Phone number")
        passwordField.giveDefaultPlaceHolder(text: "Enter password")
        
        
        
        let forgotText = "Forgot your password? Click to restore"
        let coloringText = "Click to restore"
        let mutableAttributedStr = Utilities.colorTextView(with: forgotText, coloredText: coloringText, color: UIColor(named: "correctInput") ?? .green)
        forgotPasswordTextView.attributedText = mutableAttributedStr
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnTextView(_:)))
        forgotPasswordTextView.addGestureRecognizer(tapGesture)
        
        //testFillup()
    }
    
    @objc private final func tapOnTextView(_ tapGesture: UITapGestureRecognizer){

      let point = tapGesture.location(in: forgotPasswordTextView)
        if let detectedWord = Utilities.getWordAtPosition(point, textView: forgotPasswordTextView)
      {
            print(detectedWord)
            if(detectedWord == "Click" || detectedWord == "to" || detectedWord == "restore")
            {
                self.showPasswordRecoveryWithAnimation()
            }
      }
    }
    
    
    
    private func testFillup(){
        self.emailField.text = "testsiam@test.com"
        self.passwordField.text = "12345"
    }
    
    private func showPasswordRecoveryWithAnimation()
    {
        resignAllTextFields()
        
        //3. Add a transparent layer to tap to dismiss the password view
        transparentButton = self.view.transparentShadowButton(vc: self, selector:#selector(self.removePasswordRecoveryView(sender:)))
        if let transparentButton = self.transparentButton{
            self.view.addSubview(transparentButton)
            transparentButton.translatesAutoresizingMaskIntoConstraints = false
            transparentButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            transparentButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            transparentButton.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            transparentButton.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        }
        
        //1. Password view init & customization
        passwordRecoveryView = Bundle.main.loadNibNamed("PasswordRecoveryView", owner: self, options: nil)![0] as? PasswordRecoveryView
        if let passwordRecoveryView = self.passwordRecoveryView{
            passwordRecoveryView.containerView.giveRoundedCorner(value: 10.0)
            passwordRecoveryView.frame = CGRect(x: 0, y: 700, width: self.view.frame.size.width, height: passwordRecoveryView.frame.size.height)
            passwordRecoveryView.recoveryEmailHolderView.giveGenericBorder()
            passwordRecoveryView.recoveryEmailHolderView.giveRoundedCorner(value: 5)
            passwordRecoveryView.sendButton.giveRoundedCorner(value: 5)
            passwordRecoveryView.recoveryEmailField.delegate = self
            passwordRecoveryView.sendButton.addTarget(self, action: #selector(self.sendTemporaryAction(sender:)), for: .touchUpInside)
            passwordRecoveryView.delegate = self
            
            self.view.addSubview(passwordRecoveryView)
            passwordRecoveryView.translatesAutoresizingMaskIntoConstraints = false
            passwordRecoveryView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            passwordRecoveryView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            passwordRecoveryView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            passwordRecoveryView.heightAnchor.constraint(equalToConstant: 350).isActive = true
            passwordRecoveryView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -25).isActive = true
            
            //2. Animate password view from Bottom
            
            Utilities.animateViewFromBottom(view: passwordRecoveryView) { (finished) in
                self.view.bringSubviewToFront(passwordRecoveryView)
                passwordRecoveryView.recoveryEmailField.becomeFirstResponder()
            }
        }
        
    }
    
    @objc func removePasswordRecoveryView(sender:UIButton?)
    {
        guard let passwordRecoveryView = self.passwordRecoveryView else {
            return
        }
        passwordRecoveryView.recoveryEmailField.resignFirstResponder()
        Utilities.removeViewWithAnimationForConstraint(view: passwordRecoveryView) { (finished) in
            passwordRecoveryView.removeFromSuperview()
            sender?.removeFromSuperview()
        }
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
    
    @objc func sendTemporaryAction(sender:UIButton)
    {
        if(validEmailForPasswordRecovery)
        {
            signinLogic = SignInInteractor.init(forgetPasswordMail: forgetPasswordMail!)
            signinLogic?.delegate = self
            signinLogic?.callForgetPasswordAPI()
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
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                    self.appearCorrectInput(v: self.emailHolderView)
                }
            }
            else
            {
                validEmail = false
                hideWithAnimation(hide: false, label: wrongEmailLabel)
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
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                    self.appearCorrectInput(v: self.passwordHolderView)
                }
            }
            else
            {
                validPassword = false
                hideWithAnimation(hide: false, label: wrongPasswordLabel)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                    self.appearWrongInput(v: self.passwordHolderView)
                }
            }
        }
        
        else if(textField == passwordRecoveryView?.recoveryEmailField){
            guard let passwordRecoveryView = self.passwordRecoveryView else {
                return
            }
            if(self.validateEmail(text: currentText))
            {
                validEmailForPasswordRecovery = true
                forgetPasswordMail = currentText
                hideWithAnimation(hide: true, label: passwordRecoveryView.wrongRecoveryLabel)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                    self.appearCorrectInput(v: passwordRecoveryView.recoveryEmailHolderView)
                }
            }
            else
            {
                validEmailForPasswordRecovery = false
                hideWithAnimation(hide: false, label: passwordRecoveryView.wrongRecoveryLabel)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                    self.appearWrongInput(v: passwordRecoveryView.recoveryEmailHolderView)
                }
            }
            
            if(validEmailForPasswordRecovery)
            {
                passwordRecoveryView.sendButton.backgroundColor = UIColor(named: "correctInput")
                passwordRecoveryView.sendButton.bottomGreenShadow()
            }
            else{
                passwordRecoveryView.sendButton.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
                passwordRecoveryView.sendButton.removeBottomShadow()
            }
        }
        
        if(validEmail && validPassword)
        {
            self.signInButton.backgroundColor = UIColor(named: "correctInput")
            self.signInButton.bottomGreenShadow()
        }
        else
        {
            self.signInButton.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
            self.signInButton.removeBottomShadow()
        }
    }
    
    private func validateInput() -> Bool
    {
        return true
    }
    
    private func appearWrongInput(v:UIView)
    {
        v.giveGenericBorder()
        v.setBorderColor(color: .red)
        v.backgroundColor = UIColor.init(named: "inputError")
        v.removeBottomShadow()
    }
    
    private func appearCorrectInput(v:UIView)
    {
        v.giveGenericBorder()
        v.setBorderColor(color: UIColor.init(named: "correctInput") ?? .green)
        v.backgroundColor = .clear
        v.addBottomShadow()
    }
    
    private func resignAllTextFields()
    {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
}



extension SignInViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == emailField)
        {
            passwordField.becomeFirstResponder()
            return true
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}

extension SignInViewController: PasswordRecoveryViewDelegate{
    func recoveryEmailFieldEditChanged(_ sender: UITextField) {
        colorizeFiledsAccordingToValidity(currentText: sender.text ?? "", textField: passwordRecoveryView!.recoveryEmailField)
    }
}

extension SignInViewController: SignInLogicProtocol{
    
    func signInFailed(with errorMsg: String) {
        NotificationService.showNotificationErrorView(on: self, text: errorMsg, removeAfter: 3)
        //self.showToastAtBottom(message: errorMsg)
    }
    
    func signInSuccessful() {
        Router.shared.gotoMainTab(from: self)
    }
    
    func mailMyPasswordSuccess(with msg: String) {
        if let transparentButton = self.transparentButton{
            removePasswordRecoveryView(sender: transparentButton)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            NotificationService.showNotificationSuccessView(on: self, text: msg, removeAfter: 2.5)
        }
    }
    
    func mailMyPasswordFailed(with msg: String) {
        if let transparentButton = self.transparentButton{
            removePasswordRecoveryView(sender: transparentButton)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            NotificationService.showNotificationErrorView(on: self, text: msg, removeAfter: 2.5)
        }
    }
    
}




