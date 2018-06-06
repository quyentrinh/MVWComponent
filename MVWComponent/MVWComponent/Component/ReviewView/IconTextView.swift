//
//  IconTextView.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/6/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

@IBDesignable
class IconTextView: UIView {

    @IBInspectable open var normalImage: UIImage? {
        didSet {
            if normalImage != oldValue {
                normalImageView.image = normalImage
                refreshLayout()
            }
            
        }
    }

    @IBInspectable open var highlightImage: UIImage? {
        didSet {
            if highlightImage != oldValue {
                highlightImageView.image = highlightImage
                refreshLayout()
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
    
    @IBInspectable open var text: String? {
        didSet {
            if text != oldValue {
                textLabel.text = text
                refreshLayout()
            }
        }
    }
    
    @IBInspectable open var normalTextColor: UIColor? = .darkText {
        didSet {
            if normalTextColor != oldValue {
                textLabel.textColor = normalTextColor
                refreshLayout()
            }
        }
    }
    
    @IBInspectable open var highlightTextColor: UIColor? = .blue {
        didSet {
            if highlightTextColor != oldValue {
                refreshLayout()
            }
        }
    }
    
    @IBInspectable open var systemFontSize: CGFloat = 13 {
        didSet {
            if systemFontSize != oldValue {
                textLabel.font = .systemFont(ofSize: systemFontSize)
                refreshLayout()
            }
        }
    }
    
    @IBInspectable open var highLight: Bool = false {
        didSet {
            if highLight != oldValue {
                normalImageView.isHidden = highLight
                highlightImageView.isHidden = !highLight
                textLabel.textColor = highLight ? highlightTextColor : normalTextColor
                refreshLayout()
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
        highlightImageView.isHidden = true
        let labelPositionY = imageSize.height + padding*2
        textLabel.frame = CGRect(x: 0, y: labelPositionY, width: contentFrame.width, height: contentFrame.height - labelPositionY)
        
        refreshLayout()
    }

    
    func setupUI() {
        let _normalImageView = UIImageView()
        _normalImageView.contentMode = imageContentMode
        addSubview(_normalImageView)
        normalImageView = _normalImageView
        
        let _highlightImageView = UIImageView()
        _highlightImageView.contentMode = imageContentMode
        addSubview(_highlightImageView)
        highlightImageView = _highlightImageView
        
        let _textLabel = UILabel()
        _textLabel.textAlignment = .center
        _textLabel.font = .systemFont(ofSize: systemFontSize)
        _textLabel.textColor = normalTextColor
        addSubview(_textLabel)
        textLabel = _textLabel
    }
    
    func refreshLayout() {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
