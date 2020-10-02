//
//  Utilities.swift
//  designUI
//
//  Created by Siam on 9/29/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    //MARK: View related
    class func animateViewFromBottom(view:UIView,duration:(Double) = 0.3, completions: @escaping ((Bool) -> Void))
    {
        view.alpha = 0
        UIView.animate(withDuration: duration) {
            view.frame = CGRect(x: 0, y: 250, width: view.frame.size.width, height: view.frame.size.height)
            view.alpha = 1.0
        } completion: { (finished) in
            completions(finished)
        }
    }
    
    class func removeViewWithAnimation(view:UIView,duration:(Double) = 0.3, completions: @escaping ((Bool) -> Void))
    {
        UIView.animate(withDuration: duration) {
            view.frame = CGRect(x: 0, y: 750, width: view.frame.size.width, height: view.frame.size.height)
        } completion: { (finished) in
            completions(finished)
        }
    }
    
    class func removeViewWithAnimationForConstraint(view:UIView,duration:(Double) = 0.3, completions: @escaping ((Bool) -> Void))
    {
        view.topAnchor.constraint(equalTo: view.superview!.topAnchor, constant: 900).isActive = true
        UIView.animate(withDuration: duration) {
            view.alpha = 0.1
            view.superview!.layoutIfNeeded()
        } completion: { (finished) in
            completions(finished)
        }
    }
    
    //MARK: String / Text related
    
    class func colorTextView(with fullText:String, coloredText: String, color:UIColor) -> NSMutableAttributedString
    {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let myMutableString = NSMutableAttributedString(string: fullText,attributes: [ NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        if let nsRange = fullText.range(of: coloredText)?.nsRange(in: fullText) {
            (fullText as NSString).substring(with: nsRange)
            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color as Any, range:nsRange)
        }
        
        return myMutableString
    }
    
    class func getWordAtPosition(_ point: CGPoint, textView:UITextView) -> String?{
        if let textPosition = textView.closestPosition(to: point)
        {
            if let range = textView.tokenizer.rangeEnclosingPosition(textPosition, with: .word, inDirection: UITextDirection(rawValue: 1))
          {
            return textView.text(in: range)
          }
        }
    return nil
        
    }

}
