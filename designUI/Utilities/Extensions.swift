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
}

extension UITextField{
    func giveDefaultPlaceHolder(text:String)
    {
        self.attributedPlaceholder = NSAttributedString(string:text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
}


