//
//  NavigationDemoVC.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/8/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class NavigationDemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        let frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 44.0)
        let button1 = UIButton(type: .contactAdd)
        button1.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        let button2 = UIButton(type: .infoDark)
        let button3 = UIButton(type: .detailDisclosure)
        let navigaiton = CustomNavigationBar(leftItems: [button1], rightItems: [button2, button3], barType: .title, frame: frame)
        navigaiton.title = "QT NAvigation"
        view.addSubview(navigaiton)
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
