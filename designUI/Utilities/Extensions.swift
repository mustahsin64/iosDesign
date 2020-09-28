//
//  Extensions.swift
//  designUI
//
//  Created by Siam on 9/26/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{

    func showToastInCenter(message : String, font: UIFont)
    {
        //let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height/2, width: 200, height: 50))
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.numberOfLines = 0;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
                 toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
        
    }
    
    func showToastAtBottom(message : String, font: UIFont = .systemFont(ofSize: 12.0))
    {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height-120, width: 200, height: 50))
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.numberOfLines = 0;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
                 toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
        
    }
    
}

extension UIView{
    
    func giveGenericBorder(){
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
    }
    
    func giveRoundedCorner(value:Float){
        self.layer.cornerRadius = CGFloat(value)
        self.layer.masksToBounds = true
    }
    
    func makeCircular(){
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
    }
    
    func setBorderColor(color:UIColor)
    {
        self.layer.borderColor = color.cgColor
        self.layer.masksToBounds = true
    }
    
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0 , height: 2)
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: bounds.maxY - layer.shadowRadius,
                                                     width: bounds.width,
                                                     height: layer.shadowRadius)).cgPath
    }
    
    func removeBottomShadow() {
        layer.masksToBounds = true
        layer.shadowRadius = 0
        layer.shadowOpacity = 0
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0 , height: 3)
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: 0,
                                                     width: 0,
                                                     height: 0)).cgPath
    }
}

extension UITextField{
    func giveDefaultPlaceHolder(text:String)
    {
        self.attributedPlaceholder = NSAttributedString(string:text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
}

extension UIImageView{
//    func makeCircular(){
//        self.layer.cornerRadius = self.frame.size.height/2
//        self.layer.masksToBounds = true
//    }
}

extension UIColor{
    
}

extension String{
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}


