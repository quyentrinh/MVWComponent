//
//  LeftPanelDemoVC.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 5/31/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class LeftPanelDemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segment = SegmentBarView(frame: CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 60))
        view.addSubview(segment)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func showButtonTapped(_ sender: Any) {
        let vc = MenuViewController()
        showMenu(vc)
    }
    
}
