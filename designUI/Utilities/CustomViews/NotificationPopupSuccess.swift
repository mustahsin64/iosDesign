//
//  NotificationPopupView.swift
//  designUI
//
//  Created by Siam on 10/2/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit

class NotificationPopupSuccess: UIView {

    @IBOutlet var textView: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        print("NotificationPopupSuccess deinitialized")
    }
}
