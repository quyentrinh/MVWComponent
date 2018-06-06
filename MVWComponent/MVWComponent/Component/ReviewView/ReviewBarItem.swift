//
//  ReviewBarItem.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/6/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

@IBDesignable
class ReviewBarItem: UIView {
    
    @IBInspectable open var normalImage: UIImage? {
        didSet {
            if normalImage != oldValue {
                normalImageView.backgroundColor = .clear
                normalImageView.image = normalImage
            }
        }
    }
    
    @IBInspectable open var highlightImage: UIImage? {
        didSet {
            if highlightImage != oldValue {
                highlightImageView.backgroundColor = .clear
                highlightImageView.image = highlightImage
            }
        }
    }
    
    @IBInspectable open var imageSize: CGSize = CGSize(width: 20.0, height: 20.0) {
        didSet {
            if imageSize != oldValue {
                layoutIfNeeded()
            }
        }
    }
    
    @IBInspectable open var text: String = "Label" {
        didSet {
            if text != oldValue {
                updateTextDisplay()
            }
        }
    }
    
    @IBInspectable open var normalTextColor: UIColor = .darkText {
        didSet {
            if normalTextColor != oldValue {
                updateTextDisplay()
            }
        }
    }
    
    @IBInspectable open var highlightTextColor: UIColor = .blue {
        didSet {
            if highlightTextColor != oldValue {
                updateTextDisplay()
            }
        }
    }
    
    @IBInspectable open var systemFontSize: CGFloat = 13 {
        didSet {
            if systemFontSize != oldValue {
                textLabel.font = .systemFont(ofSize: systemFontSize, weight: .light)
            }
        }
    }
    
    @IBInspectable open var highLight: Bool = false {
        didSet {
            if highLight != oldValue {
                normalImageView.isHidden = highLight
                highlightImageView.isHidden = !highLight
                updateTextDisplay()
            }
        }
    }
    
    open var imageContentMode: UIViewContentMode = UIViewContentMode.scaleAspectFit
    private let padding: CGFloat = 5.0
    private var normalImageView: UIImageView!
    private var highlightImageView: UIImageView!
    private var textLabel: UILabel!
    
    //MARK:- SETUP
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let contentFrame = bounds
        let imagePositionX = (contentFrame.width - imageSize.width) / 2
        normalImageView.frame = CGRect(origin: CGPoint(x: imagePositionX, y: padding), size: imageSize)
        highlightImageView.frame = normalImageView.frame
        let labelPositionY = imageSize.height + padding*2
        textLabel.frame = CGRect(x: 0, y: labelPositionY, width: contentFrame.width, height: contentFrame.height - labelPositionY)
        
        refreshLayout()
    }
    
    
    func setupUI() {
        let _normalImageView = UIImageView()
        _normalImageView.backgroundColor = .groupTableViewBackground
        _normalImageView.contentMode = imageContentMode
        addSubview(_normalImageView)
        normalImageView = _normalImageView
        
        let _highlightImageView = UIImageView()
        _highlightImageView.backgroundColor = .groupTableViewBackground
        _highlightImageView.contentMode = imageContentMode
        _highlightImageView.isHidden = true
        addSubview(_highlightImageView)
        highlightImageView = _highlightImageView
        
        let _textLabel = UILabel()
        _textLabel.textAlignment = .center
        _textLabel.font = .systemFont(ofSize: systemFontSize, weight: .light)
        addSubview(_textLabel)
        textLabel = _textLabel
    }
    
    func refreshLayout() {
        if let normalImg = normalImage {
            normalImageView.image = normalImg
        }
        if let highlightImg = highlightImage {
            highlightImageView.image = highlightImg
        }
        textLabel.font = .systemFont(ofSize: systemFontSize, weight: .light)
        normalImageView.isHidden = highLight
        highlightImageView.isHidden = !highLight
        updateTextDisplay()
    }
    
    
    func updateTextDisplay() {
        textLabel.textColor = normalTextColor           //set color for "|"
        let attribute = NSMutableAttributedString(string: text)
        if text.contains("|") {
            // if have this character, it's highlight
            let strings = text.components(separatedBy: "|")
            attribute.setColorForText(textForAttribute: strings[0], withColor: highlightTextColor)
            attribute.setColorForText(textForAttribute: strings[1], withColor: normalTextColor)
        } else {
            let color = highLight ? highlightTextColor : normalTextColor
            attribute.setColorForText(textForAttribute: text, withColor: color)
        }
        textLabel.attributedText = attribute
    }
    
    
}


extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
    }
    
}

