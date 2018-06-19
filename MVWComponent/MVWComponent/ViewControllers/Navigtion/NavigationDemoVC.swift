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
        
        view.backgroundColor = .groupTableViewBackground
    
        var frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 64.0)

        let nav1 = CustomNavigationBar(leftItems: nil, rightItems: nil, barType: .title, frame: frame)
        nav1.title = "映画館を探す"
        view.addSubview(nav1)
        
        frame.origin.y += 70
        let nav2 = CustomNavigationBar(leftItems: nil, rightItems: nil, barType: .subTitle, frame: frame)
        nav2.title = "ラプラスの魔女"
        nav2.subTitle = "132分"
        view.addSubview(nav2)

        frame.origin.y += 70
        let nav3 = CustomNavigationBar(leftItems: nil, rightItems: nil, barType: .logo, frame: frame)
        view.addSubview(nav3)
        
        frame.origin.y += 70
        let nav4 = CustomNavigationBar(leftItems: nil, rightItems: nil, barType: .notification, frame: frame)
        nav4.title = "お知らせ"
        nav4.notification = "5"
        view.addSubview(nav4)
        
        frame.origin.y += 70
        let nav5 = CustomNavigationBar(leftItems: nil, rightItems: nil, barType: .search, frame: frame)
        view.addSubview(nav5)
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
        print("KAKAKA")
    }

}
