//
//  OrderTopView.swift
//  designUI
//
//  Created by Siam on 9/26/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit

class OrderTopView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //commonInit()
    }
    
    func commonInit()
    {
        let view = Bundle.main.loadNibNamed("OrderTopView", owner: self, options: nil)![0] as! UIView
        view.frame = self.bounds
        addSubview(view)
    }
    
}
