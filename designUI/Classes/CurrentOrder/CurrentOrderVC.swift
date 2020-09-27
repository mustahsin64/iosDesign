//
//  CurrentOrderVC.swift
//  designUI
//
//  Created by Siam on 9/26/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit
import SDWebImage

class CurrentOrderVC: UIViewController {
    
    @IBOutlet var currentOrderTopView1: OrderTopView!
    
    @IBOutlet var topView: UIView!
    @IBOutlet var contentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print()
    }
    
    override func viewDidLayoutSubviews() {
        setupTopNavView()
    }
    

    //MARK: internal methods
    private func customizeUI()
    {
        contentView.giveRoundedCorner(value: 10)
        overrideUserInterfaceStyle = .light
    }
    
    private func setupTopNavView()
    {
        currentOrderTopView1.frame = CGRect(x: 0, y: 0, width: self.topView.frame.size.width, height: self.topView.frame.size.height)
        self.topView.addSubview(currentOrderTopView1)
        let imageURL : URL? = URL(string: "https://s3-us-west-2.amazonaws.com/qt.com.dashboard.profile.driver/3d9a2138bad04754a039c22b8c3caed0.jpg")
        
        if let imageURL = imageURL{
            currentOrderTopView1.profileImageView.sd_setImage(with: imageURL, completed: nil)
            currentOrderTopView1.profileImageView.makeCircular()
        }
    }

}
