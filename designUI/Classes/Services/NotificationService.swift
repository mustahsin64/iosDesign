//
//  NotificationService.swift
//  designUI
//
//  Created by Siam on 10/2/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit
import AVKit

class NotificationService: NSObject {
    
    class func showNotificationSuccessView(on parent:UIViewController,text:String, removeAfter:Double)
    {
        let notificationPopupSuccessView = Bundle.main.loadNibNamed("NotificationPopupSuccess", owner: parent, options: nil)![0] as? NotificationPopupSuccess
        
        if let notificationPopupSuccessView = notificationPopupSuccessView{
            notificationPopupSuccessView.translatesAutoresizingMaskIntoConstraints = false
            notificationPopupSuccessView.giveRoundedCorner(value: 10)
            notificationPopupSuccessView.frame = CGRect(x: 0, y: 44, width: parent.view.frame.size.width - 48, height: 56)
            notificationPopupSuccessView.textView.text = text
            parent.view.addSubview(notificationPopupSuccessView)
            
            notificationPopupSuccessView.leftAnchor.constraint(equalTo: parent.view.leftAnchor, constant: 24).isActive = true
            notificationPopupSuccessView.rightAnchor.constraint(equalTo: parent.view.rightAnchor, constant: -24).isActive = true
            notificationPopupSuccessView.topAnchor.constraint(equalTo: parent.view.topAnchor, constant: 44).isActive = true
            notificationPopupSuccessView.heightAnchor.constraint(equalToConstant: 56).isActive = true
            
            //play an alert sound
            //https://github.com/TUNER88/iOSSystemSoundsLibrary
            AudioServicesPlaySystemSound(1000)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+removeAfter) {
                notificationPopupSuccessView.removeFromSuperview()
            }
        }
    }
    
    class func showNotificationErrorView(on parent:UIViewController, text:String, removeAfter:Double)
    {
        let notificationPopupErrorView = Bundle.main.loadNibNamed("NotificationPopupError", owner: parent, options: nil)![0] as? NotificationPopupError
        
        if let notificationPopupErrorView = notificationPopupErrorView{
            notificationPopupErrorView.translatesAutoresizingMaskIntoConstraints = false
            notificationPopupErrorView.giveRoundedCorner(value: 10)
            notificationPopupErrorView.frame = CGRect(x: 0, y: 44, width: parent.view.frame.size.width - 48, height: 56)
            notificationPopupErrorView.textView.text = text
            parent.view.addSubview(notificationPopupErrorView)
            
            notificationPopupErrorView.leftAnchor.constraint(equalTo: parent.view.leftAnchor, constant: 24).isActive = true
            notificationPopupErrorView.rightAnchor.constraint(equalTo: parent.view.rightAnchor, constant: -24).isActive = true
            notificationPopupErrorView.topAnchor.constraint(equalTo: parent.view.topAnchor, constant: 44).isActive = true
            notificationPopupErrorView.heightAnchor.constraint(equalToConstant: 56).isActive = true
            
            //play an alert sound
            //https://github.com/TUNER88/iOSSystemSoundsLibrary
            AudioServicesPlaySystemSound(1000)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+removeAfter) {
                UIView.animate(withDuration: 2) {
                    notificationPopupErrorView.alpha = 0
                } completion: { (finish) in
                    notificationPopupErrorView.removeFromSuperview()
                }

                
            }
        }
    }

}
