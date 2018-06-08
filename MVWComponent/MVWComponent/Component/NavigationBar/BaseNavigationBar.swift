//
//  BaseNavigationBar.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/8/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class BaseNavigationBar: UIView {
    
    private let statusBarHeigh: CGFloat = 0.0
    private let padding: CGFloat = 8.0
    private let buttonSize: CGSize = CGSize(width: 40.0, height: 44.0)
    
    open var titleView: UIView?
    
    open var leftButtons: [UIButton]?
    
    open var rightButtons: [UIButton]?
    
    //MARK:- SETUP

    init(leftItems: [UIButton]?, rightItems: [UIButton]?, frame: CGRect) {
        super.init(frame: frame)
        leftButtons = leftItems
        rightButtons = rightItems
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        let contentFrame = bounds
        var xLeftSpace: CGFloat = 0.0
        var xRightSpace: CGFloat = 0.0
        if let _leftButtons = leftButtons {
            for i in 0..<_leftButtons.count {
                let button = _leftButtons[i]
                let positionX = (buttonSize.width + padding)*CGFloat(i) + padding
                button.frame = CGRect(x: positionX, y: statusBarHeigh, width: buttonSize.width, height: buttonSize.height)
                xLeftSpace = positionX + buttonSize.width
            }
        }
        
        if let _rightButtons = rightButtons {
            for i in 0..<_rightButtons.count {
                let button = _rightButtons[i]
                xRightSpace = (padding + buttonSize.width)*CGFloat(i+1)
                let positionX = contentFrame.width - xRightSpace
                button.frame = CGRect(x: positionX, y: statusBarHeigh, width: buttonSize.width, height: buttonSize.height)
            }
        }
        
        let titleViewPositionX = ((xLeftSpace > xRightSpace) ? xLeftSpace : xRightSpace) + padding
        titleView?.frame = CGRect(x: titleViewPositionX, y: statusBarHeigh, width: contentFrame.width - titleViewPositionX*2, height: buttonSize.height)
        
    }

    //MARK: - UI
    func setupUI() {
        backgroundColor = .white
        if let _leftButtons = leftButtons {
            for button in _leftButtons {
                button.backgroundColor = .gray
                addSubview(button)
            }
        }
        if let _rightButtons = rightButtons {
            for button in _rightButtons {
                button.backgroundColor = .gray
                addSubview(button)
            }
        }
        let view = UIView()
        view.backgroundColor = .groupTableViewBackground
        view.clipsToBounds = true
        addSubview(view)
        titleView = view
        
    }

}
