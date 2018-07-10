//
//  DropMenuViewController.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 7/10/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class DropMenuView: UIView {

    private var contentView: UIView!
    
    private var appWindow: UIWindow {
        guard let window = UIApplication.shared.keyWindow else {
            debugPrint("KeyWindow not set. Returning a default window for unit testing.")
            return UIWindow()
        }
        return window
    }
    
    private let height: CGFloat = 330.0
    private let navigationBarHeight: CGFloat = 44.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createUI()
    }
    
    // MARK: - Create UI
    
    func createUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        clipsToBounds = true
        
        //content view
        let _contentView = UIView()
        _contentView.backgroundColor = .white
        addSubview(_contentView)
        contentView = _contentView
        
        addTapGesture()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let frame = self.frame
        contentView.frame = CGRect(x: 0, y: -height, width: frame.width, height: height)

        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.frame.origin.y += self.height
        }) { _ in
            self.layoutIfNeeded()
        }
    }

    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        tap.delegate = self
        addGestureRecognizer(tap)
    }
    
    
    @objc func dismissPopup() {
        dismiss()
    }

}

extension DropMenuView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}

extension DropMenuView {
    func show() {
        appWindow.addSubview(self)
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.frame.origin.y -= self.height
            self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
}
