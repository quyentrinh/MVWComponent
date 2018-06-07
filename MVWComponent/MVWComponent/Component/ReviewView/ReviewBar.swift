//
//  ReviewBar.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/6/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

protocol ReviewBarDatasource: class {
    func reviewBar(_ segmentbar: ReviewBar, titleForItemAt Index: Int) -> String?
    func reviewBar(_ segmentbar: ReviewBar, normalImageForItemAt Index: Int) -> UIImage?
    func reviewBar(_ segmentbar: ReviewBar, highLightImageForItemAt Index: Int) -> UIImage?
    func reviewBar(_ segmentbar: ReviewBar, shouldHighLightForItemAt Index: Int) -> Bool
}

protocol ReviewBarDelegate: class {
    func reviewBar(_ segmentbar: ReviewBar, didSelectItemAt Index: Int)
}

@IBDesignable
class ReviewBar: UIView {
    
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
    
    weak var delegate : ReviewBarDelegate?
    weak var datasource : ReviewBarDatasource? {
        didSet {
            updateDisplay()
        }
    }
    private var tagOffset = 100
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
        
        for i in 0..<itemsNumber {
            let item = ReviewBarItem(frame: .zero)
            item.tag = i + tagOffset
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(itemTapRecognizer(_:)))
            item.addGestureRecognizer(recognizer)
            addSubview(item)
            reviewItems.append(item)
        }
    }
    
    func updateDisplay() {
        //update data from datasource
        for i in 0..<itemsNumber {
            let item = reviewItems[i]
            if let image = datasource?.reviewBar(self, normalImageForItemAt: i) {
                item.normalImage = image
            }
            if let image = datasource?.reviewBar(self, highLightImageForItemAt: i) {
                item.highlightImage = image
            }
            if let title = datasource?.reviewBar(self, titleForItemAt: i) {
                item.text = title
            }
            if let highligh = datasource?.reviewBar(self, shouldHighLightForItemAt: i) {
                item.highLight = highligh
            }
        }
    }
    
    @objc func itemTapRecognizer(_ recognizer: UITapGestureRecognizer) {
        let item = recognizer.view as! ReviewBarItem
        let index = item.tag - tagOffset
        if let action = delegate?.reviewBar(self, didSelectItemAt: index) {
            action
        }
    }
    
    //MARK:- Refresh DISPLAY
    
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
