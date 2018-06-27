//
//  MenuHeaderCell.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/26/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

enum MenuHeaderType {
    case iconText
    case imageGroup
    case textH1         //with background
    case textH2         //with left indent
    case textH3         //just text
    case blank          //empty view
    
    var textColor: UIColor {
        switch self {
        case .textH1, .iconText:
            return #colorLiteral(red: 0.1098039216, green: 0.1176470588, blue: 0.1294117647, alpha: 1)
        case .textH2:
            return #colorLiteral(red: 0.2980392157, green: 0.3215686275, blue: 0.3568627451, alpha: 1)
        case .textH3:
            return #colorLiteral(red: 0.2901960784, green: 0.4078431373, blue: 0.6196078431, alpha: 1)
        default :
            return .white
        }
    }
    
    var textFont: UIFont {
        switch self {
        case .textH2:
            return UIFont.systemFont(ofSize: 12, weight: .thin)
        case .textH3:
            return UIFont.systemFont(ofSize: 12, weight: .regular)
        default :
            return UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .textH1:
            return UIColor(red: 230/255.0, green: 236/255.0, blue: 241/255.0, alpha: 1.0)
        default :
            return .white
        }
    }
    
}

protocol MenuHeaderViewDelegate: class {
    func menuHeader(_ header: MenuHeaderCell,didTapAt section: Int)
    func menuHeader(_ header: MenuHeaderCell, didTapImageIn section: Int, At index: Int)
}

class MenuHeaderCell: UITableViewCell {
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    private let padding : CGFloat = 12.0
    private let iconSize : CGFloat = 16.0
    private let imageSize : CGFloat = 28.0
    private let arrowSize : CGFloat = 16.0
    private let tagOffSet : Int = 100
    
    private var titleLabel : UILabel!
    private var iconImageView : UIImageView!
    private var arrowImageView : UIImageView!
    
    private var sectionModel: MenuSectionModel?
    
    var section: Int?
    
    weak var delegate : MenuHeaderViewDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func updateHeader(model: MenuSectionModel?, frame: CGRect = .zero) {
        sectionModel = model
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let arrow = arrowImageView {
            arrow.frame = CGRect(x: bounds.width - padding - arrowSize + 5.0, y: (bounds.height - arrowSize) / 2, width: arrowSize, height: arrowSize)
        }
        
        guard let model = sectionModel else { return }
        
        switch model.type! {
        case .textH1, .textH3:
            updateLayoutOnlyTextHeaderView(indent: 0)
            break
        case .textH2:
            updateLayoutOnlyTextHeaderView(indent: iconSize + padding)
        case .imageGroup:
            updateLayoutImageGroupHeaderView()
            break
        case .iconText:
            updateLayoutIconTextHeaderView()
            break
        default:
            return
        }
        updateDisplay()
    }
    
    
    func setupUI() {
        
        selectionStyle = .none
        
        guard let model = sectionModel else { return }
        
        backgroundColor = model.type!.backgroundColor
//        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
        
        if model.isExpandable {
            let arrow = UIImageView(image: #imageLiteral(resourceName: "ic_menu_arrow"))
            addSubview(arrow)
            arrowImageView = arrow
        }
        
        switch model.type! {
        case .textH1, .textH2, .textH3:
            createOnlyTextHeaderView(model: model)
            break
        case .imageGroup:
            createImageGroupHeaderView(model: model)
            break
        case .iconText:
            createIconTextHeaderView(model: model)
            break
        default:
            return
        }
    }
    
    //MARK: - Create UI
    
    func createOnlyTextHeaderView(model: MenuSectionModel) {
        let textLabel  = UILabel(frame: .zero)
        textLabel.font = model.type!.textFont
        textLabel.textColor = model.type!.textColor
        addSubview(textLabel)
        self.titleLabel = textLabel
    }
    
    func createImageGroupHeaderView(model: MenuSectionModel) {
        guard let model = sectionModel else { return }
        if let _images = model.imagesName {
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
    
    func createIconTextHeaderView(model: MenuSectionModel) {
        let icon = UIImageView(frame: .zero)
        icon.contentMode = .scaleToFill
        icon.clipsToBounds = true
        addSubview(icon)
        self.iconImageView = icon
        
        let textLabel  = UILabel(frame: .zero)
        textLabel.font = model.type!.textFont
        textLabel.textColor = model.type!.textColor
        addSubview(textLabel)
        self.titleLabel = textLabel
    }
    
    //MARK: - Update Layout
    
    func updateLayoutOnlyTextHeaderView(indent: CGFloat) {
        let contentFrame = bounds
        titleLabel.frame  = CGRect(x: padding + indent, y: 0, width: contentFrame.width - padding, height: contentFrame.height)
    }
    
    func updateLayoutImageGroupHeaderView() {
        let contentFrame = bounds
        guard let model = sectionModel else { return }
        if let _images = model.imagesName {
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
        self.titleLabel.frame = CGRect(x: padding*2 + iconSize, y: 0, width: contentFrame.width - iconSize - padding*2, height: contentFrame.height)
    }
    
    
    //MARK: - Handle
    
    func setHeaderExpand(flag :Bool) {
        if let arrow = arrowImageView {
            arrow.rotate(flag ? .pi / 2 : 0.0)
        }
    }
    
    func updateDisplay() {
        guard let model = sectionModel else { return }
        
        if let _text = model.title {
            titleLabel.text = _text
        }
        if let _icon = model.iconName {
            iconImageView.image = UIImage(named: _icon)
        }
        if let _images = model.imagesName {
            for i in 0..<_images.count {
                let imageView = viewWithTag(i + tagOffSet) as! UIImageView
                imageView.image = UIImage(named: _images[i])
            }
        }
    }
    
    @objc private func didTapHeader() {
        if let action = delegate?.menuHeader(self, didTapAt: section!) {
            action
        }
        
    }
    
    @objc func imageTapRecognizer(_ recognizer: UITapGestureRecognizer) {
        let image = recognizer.view as! UIImageView
        let index = image.tag - tagOffSet
        if let action = delegate?.menuHeader(self, didTapImageIn: section!, At: index) {
            action
        }
    }
}


extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
    }
}
