//
//  PullUpDemoVC.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 5/30/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class PullUpDemoVC: BaseViewController {

    let button1 = UIButton(type: .contactAdd)
    let button2 = UIButton(type: .infoDark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nav_title = "PullUp Demo"
        notification = "7"
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showMeButtonTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DEMO")
        let navigation = UINavigationController(rootViewController: vc!)
        let pullupVC = PullUpViewController(content: navigation)
        pullupVC.datasource = self
        pullupVC.delegate = self
        pullupVC.topMargin = 60
        pullupVC.headerHeight = 40
        addPullUpController(pullupVC)
    }
    
    override func navigationBarType() -> NavigationBarType {
        return .notification
    }
    
    override func navigationBarRightItems() -> Array<UIButton>? {
        return [button2]
    }
}

extension PullUpDemoVC : PullUpDataSource, PullUpDataDelegate {
    
    func imageForCloseButton() -> UIImage? {
        return UIImage(named: "ic_dismiss")
    }
    

    func viewForHeaderBar() -> UIView? {
        let vview = Bundle.main.loadNibNamed("PullUpHeader", owner: nil, options: nil)![0] as! UIView
        return vview
    }
    
    func pullUpViewControllerDidDisappear() {
        print("Dismiss")
    }
}
