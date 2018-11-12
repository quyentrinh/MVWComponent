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
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigation = navigationController {
            navigation.interactivePopGestureRecognizer?.delegate = self
            navigation.interactivePopGestureRecognizer?.isEnabled = true
            navigation.navigationBar.sizeToFit()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var additionalSafeAreaInsets: UIEdgeInsets {
        set {
            if #available(iOS 11.0, *) {
                super.additionalSafeAreaInsets = UIEdgeInsetsMake(ZZNavigationBar.customHeight - ZZNavigationBar.defaultHeight - ZZNavigationBar.backgroundViewTopMargin, 0, 0, 0)
            }
        }

        get {
            return UIEdgeInsetsMake(ZZNavigationBar.customHeight - ZZNavigationBar.defaultHeight - ZZNavigationBar.backgroundViewTopMargin, 0, 0, 0)
        }
    }
    
}

//MARK: - SETUP NAVIGATION BAR


extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension BaseViewController {
    
    func addNavigation() {
        
        var leftItem = navigationBarLeftItems()
        
        if leftItem == nil {
            leftItem = Array<UIButton>()
        }
        leftItem?.insert(backButton(), at: 0)
        
        let navBar = CustomNavigationBar(leftItems: leftItem, rightItems: navigationBarRightItems(), barType: navigationBarType(), frame: .zero)
    
        view.addSubview(navBar)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
        
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

class ZZNavigationBar: UINavigationBar {
    
    // NavigationBar height
    static let defaultHeight : CGFloat = 44
    static let customHeight : CGFloat = 80
    static let backgroundViewTopMargin: CGFloat = 20
    
    var needUpdateBackground: Bool = false
    var needUpdateContent: Bool = false
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: ZZNavigationBar.customHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("It called")
        
        self.tintColor = .black

        for subview in self.subviews {
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("UIBarBackground") {
                subview.backgroundColor = .white
                subview.frame = CGRect(x: 0, y: -ZZNavigationBar.backgroundViewTopMargin, width: self.frame.width, height: ZZNavigationBar.customHeight)
                subview.sizeToFit()
            }
            stringFromClass = NSStringFromClass(subview.classForCoder)
            //Can't set height of the UINavigationBarContentView
            if stringFromClass.contains("UINavigationBarContentView") {
                //Set Center Y
                let centerY = (ZZNavigationBar.customHeight - ZZNavigationBar.backgroundViewTopMargin - subview.frame.height) / 2.0
                subview.frame = CGRect(x: 0, y: centerY, width: self.frame.width, height: subview.frame.height)
                subview.sizeToFit()
                
            }
        }
        
        
    }
}
