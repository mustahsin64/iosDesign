//
//  Router.swift
//  designUI
//
//  Created by Siam on 9/26/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit


struct Storyboards {
    let HomeTabbar:String = "HomeTabbar"
}

class Router{
    
    static let shared = Router()
    let storyBoardsInstance:Storyboards!
    
    
    private init(){
        storyBoardsInstance = Storyboards()
        print(storyBoardsInstance.HomeTabbar)
    }
    
    func gotoMainTab(from viewController:UIViewController)
    {
        let storyBoard = UIStoryboard(name: storyBoardsInstance.HomeTabbar, bundle: nil)
        let vc : HomeTabbarVC = storyBoard.instantiateInitialViewController() as! HomeTabbarVC
        
        guard let window = viewController.view.window else {
            return
        }
        
        window.rootViewController = vc
        self.showWithAnimation(window: window)
    }
    
    private func showWithAnimation(window:UIWindow)
    {
        //self.view.window?.makeKeyAndVisible()
        
        // A mask of options indicating how you want to perform the animations.
        let options: UIView.AnimationOptions = .transitionCrossDissolve

        // The duration of the transition animation, measured in seconds.
        let duration: TimeInterval = 0.5

        // Creates a transition animation.
        // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
        { completed in
            // maybe do something on completion here
        })
    }
}
