//
//  MenuSectionView.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/7/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

enum MenuSectionType {
    case onlyText
    case textHeading
    case imageGroup
    case iconText
    
    var identifier: String {
        switch self {
        case .onlyText:
            return "onlyText"
        case .textHeading:
            return "textHeading"
        case .imageGroup:
            return "imageGroup"
        case .iconText:
            return "iconText"
        }
    }
    
}


protocol MenuSectionViewDelegate: class {
    func menuSection(header: MenuSectionView,didTapAt section: Int)
    func menuSection(header: MenuSectionView, didTapImageIn section: Int, At index: Int)
}

class MenuSectionView: UIView {

    private var type : MenuSectionType = .onlyText
    private let padding : CGFloat = 15.0
    private let iconSize : CGFloat = 20.0
    private let imageSize : CGFloat = 30.0
    
    private let tagOffSet : Int = 100
    
    private var textLabel : UILabel!
    private var iconImageView : UIImageView!
    
    private var imagesNameArray: [String]?
    private var iconName: String?
    private var text: String?
    
    var section: Int?
    
    weak var delegate : MenuSectionViewDelegate?
    
    //MARK:- SETUP
    
    init(title: String, frame: CGRect) {
        super.init(frame: frame)
        type = .onlyText
        text = title
        setupUI()
    }
    
    init(headingTitle: String, frame: CGRect) {
        super.init(frame: frame)
        type = .textHeading
        text = headingTitle
        setupUI()
    }
    
    init(title: String, icon: String, frame: CGRect) {
        super.init(frame: frame)
        type = .iconText
        text = title
        iconName = icon
        setupUI()
    }
    
    init(images: [String], frame: CGRect) {
        super.init(frame: frame)
        imagesNameArray = images
        type = .imageGroup
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch type {
        case .onlyText:
            updateLayoutOnlyTextHeaderView()
            break
        case .imageGroup:
            updateLayoutImageGroupHeaderView()
            break
        case .iconText:
            updateLayoutIconTextHeaderView()
            break
        case .textHeading:
            updateLayoutTextHeadingHeaderView()
            break
        }
        updateDisplay()
    }
    
    
    func setupUI() {
        switch type {
        case .onlyText:
            createOnlyTextHeaderView()
            break
        case .imageGroup:
            createImageGroupHeaderView()
            break
        case .iconText:
            createIconTextHeaderView()
            break
        case .textHeading:
            createTextHeadingHeaderView()
            break
        }
        backgroundColor = .white
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    
    @objc private func didTapHeader() {
        if let action = delegate?.menuSection(header: self, didTapAt: section!) {
            action
        }
        
    }
    //MARK: - Create UI
    
    func createOnlyTextHeaderView() {
        let textLabel  = UILabel(frame: .zero)
        textLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        addSubview(textLabel)
        self.textLabel = textLabel
    }
    
    func createImageGroupHeaderView() {
        if let _images = imagesNameArray {
            for i in 0..<_images.count {
                let imageView = UIImageView(frame: .zero)
                imageView.tag = i + tagOffSet
                imageView.clipsToBounds = true
                imageView.isUserInteractionEnabled = true
                let recognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapRecognizer(_:)))
                imageView.addGestureRecognizer(recognizer)
                
                addSubview(imageView)
            }
        }
    }
    
    func createIconTextHeaderView() {
        let icon = UIImageView(frame: .zero)
        icon.contentMode = .scaleToFill
        icon.clipsToBounds = true
        addSubview(icon)
        self.iconImageView = icon
        
        let textLabel  = UILabel(frame: .zero)
        textLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        addSubview(textLabel)
        self.textLabel = textLabel
    }
    
    func createTextHeadingHeaderView() {
        let textLabel  = UILabel(frame: .zero)
        textLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        addSubview(textLabel)
        self.textLabel = textLabel
    }
    
    
    //MARK: - Update Layout
    
    func updateLayoutOnlyTextHeaderView() {
        let contentFrame = bounds
        textLabel?.frame  = CGRect(x: padding, y: 0, width: contentFrame.width - padding, height: contentFrame.height)
    }
    
    func updateLayoutImageGroupHeaderView() {
        let contentFrame = bounds
        if let _images = imagesNameArray {
            for i in 0..<_images.count {
                let positionX = (imageSize + padding)*CGFloat(i) + padding
                let imageView = viewWithTag(i + tagOffSet) as! UIImageView
                imageView.frame = CGRect(x: positionX, y: (contentFrame.height - imageSize)/2, width: imageSize, height: imageSize)
            }
        }
    }
    
    func updateLayoutIconTextHeaderView() {
        let contentFrame = bounds
        self.iconImageView.frame = CGRect(x: padding, y: (contentFrame.height - iconSize) / 2, width: iconSize, height: iconSize)
        self.textLabel.frame = CGRect(x: padding*2 + iconSize, y: 0, width: contentFrame.width - iconSize - padding*2, height: contentFrame.height)
    }
    
    func updateLayoutTextHeadingHeaderView() {
        backgroundColor = .groupTableViewBackground
        let contentFrame = bounds
        textLabel?.frame  = CGRect(x: padding, y: 0, width: contentFrame.width - padding, height: contentFrame.height)
    }
    
    
    
    //MARK: - Handle
    
    func updateDisplay() {
        
        if let _text = text {
            textLabel.text = _text
        }
        if let _icon = iconName {
            iconImageView.image = UIImage(named: _icon)
        }
        if let _images = imagesNameArray {
            for i in 0..<_images.count {
                let imageView = viewWithTag(i + tagOffSet) as! UIImageView
                imageView.image = UIImage(named: _images[i])
            }
        }
    }
    
    @objc func imageTapRecognizer(_ recognizer: UITapGestureRecognizer) {
        let image = recognizer.view as! UIImageView
        let index = image.tag - tagOffSet
        if let action = delegate?.menuSection(header: self, didTapImageIn: section!, At: index) {
            action
        }
    }
    
    
    
    
    
    
    
    
}
