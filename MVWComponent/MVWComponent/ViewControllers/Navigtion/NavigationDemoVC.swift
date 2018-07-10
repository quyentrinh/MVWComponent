//
//  NavigationDemoVC.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/8/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class NavigationDemoVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func buttonSearchTapped(_ sender: Any) {
        let topMargin: CGFloat
        if #available(iOS 11.0, *) {
            topMargin = view.safeAreaInsets.top
        } else {
            topMargin = topLayoutGuide.length
        }
        let vc = DropMenuView.init(frame: CGRect(x: 0, y: topMargin, width: view.frame.width, height: view.frame.height))
        vc.show()
    }
    
}
