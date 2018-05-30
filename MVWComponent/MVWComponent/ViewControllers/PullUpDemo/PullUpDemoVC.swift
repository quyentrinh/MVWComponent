//
//  PullUpDemoVC.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 5/30/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class PullUpDemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
}

extension PullUpDemoVC : PullUpDataSource, PullUpDataDelegate {
    
    func imageForCloseButton() -> UIImage? {
        return UIImage(named: "ic_dismiss")
    }
    

    func headerViewForPullUp() -> UIView? {
        let vview = Bundle.main.loadNibNamed("PullUpHeader", owner: nil, options: nil)![0] as! UIView
        return vview
    }
    
    func pullUpViewControllerDidDisappear() {
        print("Dismiss")
    }
}
