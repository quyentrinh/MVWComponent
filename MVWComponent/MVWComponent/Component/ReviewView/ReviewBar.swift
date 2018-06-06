//
//  ReviewBar.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/6/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

protocol ReviewBarDelegate: class {
    func reviewBar(_ segmentbar: ReviewBar, didSelectItemAt Index: Int)
}

@IBDesignable
class ReviewBar: UIView {
    
    weak var delegate : ReviewBarDelegate?
    
    @IBInspectable open var itemsNumber: Int = 3 {
        didSet {
            if itemsNumber != oldValue {
                setupUI()
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
    
    @IBInspectable open var normalTextColor: UIColor = .darkText {
        didSet {
            if normalTextColor != oldValue {
                refreshNormalTextColor()
            }
        }
    }
    
    @IBInspectable open var highlightTextColor: UIColor = .blue {
        didSet {
            if highlightTextColor != oldValue {
                refreshHighlightTextColor()
            }
        }
    }
    
    @IBInspectable open var systemFontSize: CGFloat = 13 {
        didSet {
            if systemFontSize != oldValue {
                refreshFontSize()
            }
        }
    }
    
    private var reviewItems = [ReviewBarItem]()
    
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

        let itemWidth = contentFrame.width / CGFloat(itemsNumber) 

        for i in 0..<itemsNumber {
            let frame = CGRect(x: itemWidth*CGFloat(i), y: 0, width: itemWidth, height: contentFrame.height)
            let item = reviewItems[i]
            item.imageSize = imageSize
            item.frame = frame
        }
    }
    
    
    func setupUI() {
        removeAllItems()
        reviewItems.removeAll()
        
        for _ in 0..<itemsNumber {
            let item = ReviewBarItem(frame: .zero)
            addSubview(item)
            reviewItems.append(item)
        }
    }
    
    func removeAllItems() {
        for item in reviewItems {
            item.removeFromSuperview()
        }
    }
    
    
    func refreshFontSize() {
        for item in reviewItems {
            item.systemFontSize = systemFontSize
        }
    }
    
    func refreshNormalTextColor() {
        for item in reviewItems {
            item.normalTextColor = normalTextColor
        }
    }
    
    func refreshHighlightTextColor() {
        for item in reviewItems {
            item.highlightTextColor = highlightTextColor
        }
    }

}
