//
//  NavigationDemoVC.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/8/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class NavigationDemoVC: UIViewController {

    let button1 = UIButton(type: .contactAdd)
    let button2 = UIButton(type: .infoDark)
    let button3 = UIButton(type: .detailDisclosure)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .groupTableViewBackground
    
        var frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 44.0)
        
        button1.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        let nav1 = CustomNavigationBar(leftItems: [button1], rightItems: [button2, button3], barType: .title, frame: frame)
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func tapped() {
        print("KAKAKA")
    }

}
