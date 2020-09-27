//
//  NotificationBellView.swift
//  designUI
//
//  Created by Siam on 9/27/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit

class NotificationBellView: UIView {

    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.makeCircular()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
