//
//  NavigationDemoVC.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/8/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class NavigationDemoVC: BaseViewController {

    let button1 = UIButton(type: .contactAdd)
    let button2 = UIButton(type: .infoDark)
    let button3 = UIButton(type: .detailDisclosure)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nav_title = "Navigation Demo"
        button1.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func navigationBarType() -> NavigationBarType {
        return .logo
    }
    
    override func navigationBarLeftItems() -> Array<UIButton>? {
        return [button3]
    }
    
    override func navigationBarRightItems() -> Array<UIButton>? {
        return [button1, button2]
    }
    
    @objc func tapped() {
        let webView = WebViewController()
        webView.URL = URL(string: "https://google.com")
        navigationController?.pushViewController(webView, animated: true)
    }

}
