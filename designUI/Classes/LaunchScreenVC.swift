//
//  LaunchScreenVC.swift
//  designUI
//
//  Created by Siam on 9/27/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit

class LaunchScreenVC: UIViewController {

    @IBOutlet var containerView: UIView!
    @IBOutlet var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientColor()
        gotoMainPage()
        
    }
    
    private func gotoMainPage()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            let storyBoard = UIStoryboard(name:"Main", bundle: nil)
            let vc : SignInViewController = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            
            guard let window = self.view.window else {
                return
            }
            
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
    }
    
    private func addGradientColor()
    {
        let layer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))

        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        gradient.colors = [
          UIColor(red:0.19, green:0.78, blue:0.58, alpha:1).cgColor,
          UIColor(red:0.19, green:0.78, blue:0.58, alpha:1).cgColor,
          UIColor(red:0.88, green:0.78, blue:0.19, alpha:1).cgColor
        ]
        gradient.locations = [0, 0, 1]
        gradient.startPoint = CGPoint(x: 0.24, y: 0.87)
        gradient.endPoint = CGPoint(x: 0.88, y: -0.25)
        layer.layer.addSublayer(gradient)

        self.view.addSubview(layer)
        
        self.view.bringSubviewToFront(logoImage)
    }

}
