//
//  CustomNavigationBar.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/8/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

enum NavigationBarType {
    case title
    case subTitle
    case notification
    case logo
    case share
    case search
}

class CustomNavigationBar: BaseNavigationBar {
    
    //MARK:- PUBLIC PROPERTY
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    //MARK:- PRIVATE PROPERTY
    
    private var navigationBarType: NavigationBarType = .title
    
    private var titleLabel: UILabel!

    init(leftItems: [UIButton]?, rightItems: [UIButton]?, barType: NavigationBarType, frame: CGRect) {
        super.init(leftItems, rightItems, frame)
        navigationBarType = barType
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        
        switch navigationBarType {
        case .title:
            createTitleNavigation()
            break
        case .subTitle:
            break
        case .notification:
            break
        case .logo:
            break
        case .share:
            break
        case .search:
            break
        }

    }
    
    //MARK:- Create UI
    
    func createTitleNavigation()  {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleView?.addSubview(label)
        titleLabel = label
    }
    
    //MARK:- Update Layout

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
