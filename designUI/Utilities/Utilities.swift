//
//  Utilities.swift
//  designUI
//
//  Created by Siam on 9/29/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    //func animate(withDuration duration: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil)
    
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

}
