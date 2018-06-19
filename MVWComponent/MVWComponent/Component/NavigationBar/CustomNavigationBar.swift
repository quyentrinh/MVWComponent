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
    
    var notification: String? {
        didSet {
            notificationLabel.text = notification
        }
    }
    
    //MARK:- PRIVATE PROPERTY
    
    var navigationBarType: NavigationBarType = .title
    
    var titleLabel: UILabel!
    
    var subTitleLabel: UILabel!
    
    var notificationLabel: UILabel!
    
    var searchField: UITextField!

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
            createNotifyNavigation()
            break
        case .logo:
            createImageTitleNavigation()
            break
        case .search:
            createSearchNavigation()
            break
        }

    }
    
    //MARK:- Create UI
    
    func createTitleNavigation()  {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        
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
        icon.image = #imageLiteral(resourceName: "nav_ic_subtitle")
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
    
    func createImageTitleNavigation() {
        guard let view = titleView else { return }
        
        let image = UIImageView(frame: .zero)
        image.image = #imageLiteral(resourceName: "nav_logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor).isActive = true
        image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 200/110).isActive = true
        
    }
    
    func createNotifyNavigation() {
        
        createTitleNavigation()
        
        guard let view = titleView else { return }
        guard let titlelabel = titleLabel else { return }
        
        let labelWidth:CGFloat = 17.0
        
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.2784313725, blue: 0.5098039216, alpha: 1)
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = labelWidth*0.5
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.widthAnchor.constraint(equalToConstant: labelWidth).isActive = true
        label.heightAnchor.constraint(equalToConstant: labelWidth).isActive = true
        label.leadingAnchor.constraint(equalTo: titlelabel.trailingAnchor, constant: 10.0).isActive = true
        label.centerYAnchor.constraint(equalTo: titlelabel.centerYAnchor).isActive = true
        
        notificationLabel = label
    }
    
    func createSearchNavigation() {
        
        guard let view = titleView else { return }
        
        let search = UITextField(frame: .zero)
        search.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9254901961, blue: 0.9450980392, alpha: 1)
        search.font = UIFont.systemFont(ofSize: 13.0)
        search.textColor = #colorLiteral(red: 0.2980392157, green: 0.3215686275, blue: 0.3568627451, alpha: 1)
        search.tintColor = .black
        search.borderStyle = .none
        search.clearButtonMode = .whileEditing
        search.layer.cornerRadius = 4.0
        search.placeholder = "作品・映画館・人物を検索"
        
        let searchLView = UIView(frame: CGRect(x: 0, y: 0, width: 40.0, height: 30.0))
        let icon = UIImageView(frame: CGRect(x: 11, y: 6, width: 18.0, height: 18.0))
        icon.image = #imageLiteral(resourceName: "nav_search")
        searchLView.addSubview(icon)
        search.leftView = searchLView
        search.leftViewMode = .always
        
        search.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(search)
        
        search.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        search.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        search.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0.0).isActive = true
        search.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        searchField = search
    }
    
    //MARK:- Update Layout

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
