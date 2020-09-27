//
//  CurrentOrderVC.swift
//  designUI
//
//  Created by Siam on 9/26/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit

class CurrentOrderVC: UIViewController {
    
    @IBOutlet var currentOrderTopView1: UIView!
    
    @IBOutlet var topView: OrderTopView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(currentOrderTopView1)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
