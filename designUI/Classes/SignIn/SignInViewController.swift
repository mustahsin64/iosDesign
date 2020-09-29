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
    var validEmailForPasswordRecovery = false
    
    var passwordRecoveryView = PasswordRecoveryView()

    
    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        //appearWrongInput(v: emailHolderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailField.becomeFirstResponder()
        
//        let blackShadowView = UIView()
//        self.view.addSubview(blackShadowView)
//        blackShadowView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//        blackShadowView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
//
//        let geopointView = UIView()
//        self.view.addSubview(geopointView)
//        geopointView.frame = CGRect(x: 0, y: 800, width: self.view.frame.size.width, height: 300)
//        geopointView.backgroundColor = .systemTeal
//        UIView.animate(withDuration: 2) {
//            geopointView.frame = CGRect(x: 0, y: 250, width: self.view.frame.size.width, height: 300)
//        } completion: { (finished) in
//
//        }
        
        

        
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
        
        
        //testFillup()
    }
    
    private func testFillup(){
        self.emailField.text = "testsiam@test.com"
        self.passwordField.text = "12345"
    }
    
    private func showPasswordRecoveryWithAnimation()
    {
        resignAllTextFields()
        
        //3. Add a transparent layer to tap to dismiss the password view
        let transparentButton = self.view.transparentShadowButton(vc: self, selector:#selector(self.removePasswordRecoveryView(sender:)))
        self.view.addSubview(transparentButton)
        transparentButton.translatesAutoresizingMaskIntoConstraints = false
        transparentButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        transparentButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        transparentButton.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        transparentButton.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        
        
        //1. Password view init & customization
        passwordRecoveryView = Bundle.main.loadNibNamed("PasswordRecoveryView", owner: self, options: nil)![0] as! PasswordRecoveryView
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
        Utilities.animateViewFromBottom(view: self.passwordRecoveryView) { (finished) in
            self.view.bringSubviewToFront(self.passwordRecoveryView)
            self.passwordRecoveryView.recoveryEmailField.becomeFirstResponder()
        }
    }
    
    @objc func removePasswordRecoveryView(sender:UIButton)
    {
        self.passwordRecoveryView.recoveryEmailField.resignFirstResponder()
        Utilities.removeViewWithAnimationForConstraint(view: passwordRecoveryView) { (finished) in
            self.passwordRecoveryView.removeFromSuperview()
            sender.removeFromSuperview()
        }
    }
    
    @objc func sendTemporaryAction(sender:UIButton)
    {
        
    }
    
    //MARK: IBActions
    @IBAction func SignInClicked(_ sender: UIButton)
    {
        showPasswordRecoveryWithAnimation()
        return
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
        
        else if(textField == passwordRecoveryView.recoveryEmailField){
            
            if(self.validateEmail(text: currentText))
            {
                validEmailForPasswordRecovery = true
                hideWithAnimation(hide: true, label: self.passwordRecoveryView.wrongRecoveryLabel)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                    self.appearCorrectInput(v: self.passwordRecoveryView.recoveryEmailHolderView)
                }
            }
            else
            {
                validEmailForPasswordRecovery = false
                hideWithAnimation(hide: false, label: self.passwordRecoveryView.wrongRecoveryLabel)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                    self.appearWrongInput(v: self.passwordRecoveryView.recoveryEmailHolderView)
                }
            }
            
            if(validEmailForPasswordRecovery)
            {
                self.passwordRecoveryView.sendButton.backgroundColor = UIColor(named: "correctInput")
                self.passwordRecoveryView.sendButton.bottomGreenShadow()
            }
            else{
                self.passwordRecoveryView.sendButton.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
                self.passwordRecoveryView.sendButton.removeBottomShadow()
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
        colorizeFiledsAccordingToValidity(currentText: sender.text ?? "", textField: passwordRecoveryView.recoveryEmailField)
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






