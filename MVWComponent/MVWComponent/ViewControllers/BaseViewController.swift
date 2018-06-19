//
//  BaseViewController.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/19/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var navigationBar: CustomNavigationBar!
    
    var nav_title: String? {
        didSet {
            if let bar = navigationBar {
                switch bar.navigationBarType {
                case .notification, .subTitle, .title:
                    bar.title = nav_title
                default:
                    return
                }
            }
        }
    }
    
    var nav_subTitle: String? {
        didSet {
            if let bar = navigationBar {
                switch bar.navigationBarType {
                case .subTitle:
                    bar.subTitle = nav_subTitle
                default:
                    return
                }
            }
        }
    }
    
    var notification: String? {
        didSet {
            if let bar = navigationBar {
                switch bar.navigationBarType {
                case .notification:
                    bar.notification = notification
                default:
                    return
                }
            }
        }
    }
    
    
    func navigationBarType() -> NavigationBarType {
        return .title   //default
    }
    
    func navigationBarLeftItems() -> Array<UIButton>? {
        return nil   //default
    }
    
    func navigationBarRightItems() -> Array<UIButton>? {
        return nil  //default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigation()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: - SETUP NAVIGATION BAR




extension BaseViewController {
    
    func addNavigation() {
        
        let frame = CGRect(x: 0, y: 0, width:  view.frame.width, height: 64.0)
        
        var leftItem = navigationBarLeftItems()
        
        if leftItem == nil {
            leftItem = Array<UIButton>()
        }
        leftItem?.insert(backButton(), at: 0)
        
        let navBar = CustomNavigationBar(leftItems: leftItem, rightItems: navigationBarRightItems(), barType: navigationBarType(), frame: frame)
    
        view.addSubview(navBar)
        
        navigationBar = navBar
    }
    
    func backButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "ic_back"), for: .normal)
        button.addTarget(self, action: #selector(backButtontapped), for: .touchUpInside)
        return button
    }
    
    //MARK:- ACTION
    
    @objc func backButtontapped() {
        guard let navigationController = self.navigationController else { return }
        navigationController.popViewController(animated: true)
    }
    
}

























