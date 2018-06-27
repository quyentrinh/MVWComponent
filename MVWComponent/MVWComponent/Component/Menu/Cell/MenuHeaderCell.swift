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
    func menuHeader(_ header: MenuHeaderCell, didTapImageIn section: Int, At index: Int)
}

class MenuHeaderCell: UITableViewCell {
    
    private let padding : CGFloat = 12.0
    private let iconSize : CGFloat = 16.0
    private let imageSize : CGFloat = 28.0
    private let arrowSize : CGFloat = 16.0
    private let tagOffSet : Int = 100
    
    private var titleLabel : UILabel!
    private var iconImageView : UIImageView!
    private let maxNumberImageSocial : Int = 4
    private var arrowImageView : UIImageView!
    
    private var sectionModel: MenuSectionModel?
    
    fileprivate var headerType: MenuHeaderType?
    
    var section: Int?
    
    weak var delegate : MenuHeaderViewDelegate?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
    }
    
    func setupUI() {
        
        selectionStyle = .none
        
        backgroundColor = headerType!.backgroundColor

        let arrow = UIImageView(frame: .zero)
        arrow.image = #imageLiteral(resourceName: "ic_menu_arrow")
        arrow.isHidden = true
        addSubview(arrow)
        self.arrowImageView = arrow
        
        switch headerType! {
        case .textH1, .textH2, .textH3:
            createOnlyTextHeaderView()
            break
        case .imageGroup:
            createImageGroupHeaderView()
            break
        case .iconText:
            createIconTextHeaderView()
            break
        default:
            return
        }
    }
    
    //MARK: - Create UI
    
    func createOnlyTextHeaderView() {
        let textLabel  = UILabel(frame: .zero)
        textLabel.font = headerType!.textFont
        textLabel.textColor = headerType!.textColor
        addSubview(textLabel)
        self.titleLabel = textLabel
    }
    
    func createImageGroupHeaderView() {
        for i in 0..<maxNumberImageSocial {
            let imageView = UIImageView(frame: .zero)
            imageView.tag = i + tagOffSet
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = true
            imageView.isHidden = true
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapRecognizer(_:)))
            imageView.addGestureRecognizer(recognizer)
            
            addSubview(imageView)
        }
    }
    
    func createIconTextHeaderView() {
        let icon = UIImageView(frame: .zero)
        icon.contentMode = .scaleToFill
        icon.clipsToBounds = true
        addSubview(icon)
        self.iconImageView = icon
        
        let textLabel  = UILabel(frame: .zero)
        textLabel.font = headerType!.textFont
        textLabel.textColor = headerType!.textColor
        addSubview(textLabel)
        self.titleLabel = textLabel
    }
    
    //MARK: - Update Layout
    
    func updateLayout() {
        
        let frame = contentView.bounds
        if let arrow = arrowImageView {
            arrow.frame = CGRect(x: frame.width - padding - arrowSize + 5.0, y: (frame.height - arrowSize) / 2, width: arrowSize, height: arrowSize)
        }
        
        switch headerType! {
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

    }
    
    func updateLayoutOnlyTextHeaderView(indent: CGFloat) {
        let contentFrame = bounds
        titleLabel.frame  = CGRect(x: padding + indent, y: 0, width: contentFrame.width - padding, height: contentFrame.height)
    }
    
    func updateLayoutImageGroupHeaderView() {
        let contentFrame = bounds
        for i in 0..<maxNumberImageSocial {
            let positionX = (imageSize + padding)*CGFloat(i) + padding
            let imageView = viewWithTag(i + tagOffSet) as! UIImageView
            imageView.frame = CGRect(x: positionX, y: (contentFrame.height - imageSize)/2, width: imageSize, height: imageSize)
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
    
    func updateDisplay(model: MenuSectionModel?) {
        guard let _model = model else { return }
        
        arrowImageView.isHidden = !_model.isExpandable

        if let _text = _model.title {
            titleLabel.text = _text
        }
        if let _icon = _model.iconName {
            iconImageView.image = UIImage(named: _icon)
        }
        if let _images = _model.imagesName {
            for i in 0..<_images.count {
                let imageView = viewWithTag(i + tagOffSet) as! UIImageView
                imageView.isHidden = false
                imageView.image = UIImage(named: _images[i])
            }
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

//
//
//
//
//

class IconTextHeaderCell: MenuHeaderCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        headerType = .iconText
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

class ImageGroupHeaderCell: MenuHeaderCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        headerType = .imageGroup
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

class H1TextHeaderCell: MenuHeaderCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        headerType = .textH1
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

class H2TextHeaderCell: MenuHeaderCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        headerType = .textH2
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

class H3TextHeaderCell: MenuHeaderCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        headerType = .textH3
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

class BlankHeaderCell: MenuHeaderCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        headerType = .blank
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static var identifier: String {
        return String(describing: self)
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
