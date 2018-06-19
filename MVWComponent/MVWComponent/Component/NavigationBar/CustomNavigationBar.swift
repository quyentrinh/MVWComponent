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
    
    var subTitle: String? {
        didSet {
            subTitleLabel.text = subTitle
        }
    }
    
    //MARK:- PRIVATE PROPERTY
    
    private var navigationBarType: NavigationBarType = .title
    
    private var titleLabel: UILabel!
    
    private var subTitleLabel: UILabel!

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
            createTitleWithSubNavigation()
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
        
        guard let view = titleView else { return }
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        titleLabel = label
    }
    
    func createTitleWithSubNavigation() {
        createTitleNavigation()
        
        guard let view = titleView else { return }
        guard let titlelabel = titleLabel else { return }
        
        let icon = UIImageView(frame: .zero)
        icon.image = #imageLiteral(resourceName: "StarFull_Blue")
        icon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(icon)
        
        icon.widthAnchor.constraint(equalToConstant: 10.0).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
        icon.leadingAnchor.constraint(equalTo: titlelabel.trailingAnchor, constant: 10.0).isActive = true
        icon.bottomAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: -3.0).isActive = true
        
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 5.0).isActive = true
        label.centerYAnchor.constraint(equalTo: icon.centerYAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -3.0).isActive = true
        
        subTitleLabel = label
    }
    
    
    //MARK:- Update Layout

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
