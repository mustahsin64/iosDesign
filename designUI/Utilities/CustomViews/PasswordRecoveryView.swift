//
//  PaswordRecoveryView.swift
//  designUI
//
//  Created by Siam on 9/29/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit

protocol PasswordRecoveryViewDelegate {
    func recoveryEmailFieldEditChanged(_ sender: UITextField)
}

class PasswordRecoveryView: UIView {
    @IBOutlet var containerView: UIView!
    @IBOutlet var recoveryEmailField: UITextField!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var recoveryEmailHolderView: UIView!
    @IBOutlet var wrongRecoveryLabel: UILabel!
    
    var delegate:PasswordRecoveryViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func editingChanged(_ sender: UITextField)
    {
        if let delegate = self.delegate{
            delegate.recoveryEmailFieldEditChanged(sender)
        }
    }
    

}
