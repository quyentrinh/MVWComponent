//
//  BaseSideViewController.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 5/31/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class BaseSideViewController: UIViewController {

    
    var rightOffSet: CGFloat = 80.0

    private let buttonsize : CGFloat = 20.0
    private let padding : CGFloat = 5.0
    private var currentX : CGFloat = 0
    
    private var contentView: UIView!
    private var dismisButton: UIButton!
    private var panGestureRecognizer: UIPanGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 0.3) {
            UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar
        }
    }
    
    override func loadView() {
        setupUI()
        setupPanGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        contentView.layer.removeObserver(self, forKeyPath: "position")
    }
    
    override func viewWillLayoutSubviews() {
        contentView.frame = contentViewViewHidenFrame()
        dismisButton.frame = CGRect(x: contentView.xwidth() - buttonsize - padding, y: padding, width: buttonsize, height: buttonsize)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.frame = self.contentViewViewVisibleFrame()
        }) { _ in
            self.view.layoutIfNeeded()
            self.contentView.layer.addObserver(self, forKeyPath: "position", options: .new, context: nil)
        }
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UI
    
    private func setupUI() {
        view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        //content view
        let _contentView = UIView()
        _contentView.clipsToBounds = true
        _contentView.backgroundColor = .white
        _contentView.layer.masksToBounds = false
        _contentView.layer.shadowColor = UIColor.black.cgColor
        _contentView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        _contentView.layer.shadowOpacity = 0.5
        view.addSubview(_contentView)
        contentView = _contentView
        
        //dismis button
        let _button = UIButton()
        _button.addTarget(self, action: #selector(dismissButtonPress), for: .touchUpInside)
        _button.backgroundColor = .black
        _contentView.addSubview(_button)
        dismisButton = _button
    }
    
    private func setupPanGestureRecognizer() {
        let _panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(_:)))
        _panGestureRecognizer.minimumNumberOfTouches = 1
        _panGestureRecognizer.maximumNumberOfTouches = 1
        contentView.addGestureRecognizer(_panGestureRecognizer)
        panGestureRecognizer = _panGestureRecognizer
    }
    
    private func contentViewViewVisibleFrame() -> CGRect {
        return CGRect(x: 0, y: 0, width: view.bounds.width - rightOffSet, height: view.bounds.height)
    }
    
    private func contentViewViewHidenFrame() -> CGRect {
        return CGRect(x: rightOffSet - view.bounds.width, y: 0, width: view.bounds.width - rightOffSet, height: view.bounds.height)
    }
    
    //MARK: - SELECTOR
    
    @objc private func dismissButtonPress() {
        //        guard let completion = delegate?.pullUpViewControllerDidDisappear else {return dismissPullViewController()}
        dismiss()
    }
    
    @objc private func handlePanGestureRecognizer(_ gestureRecognizer: UIPanGestureRecognizer) {
        view.bringSubview(toFront: gestureRecognizer.view!)
        var translatePoint = gestureRecognizer.translation(in: gestureRecognizer.view?.superview)
        
        let staticY = gestureRecognizer.view?.center.y
        
        if gestureRecognizer.state == .began {
            currentX = (gestureRecognizer.view?.center.x)!
        }
        
        translatePoint = CGPoint(x: currentX + translatePoint.x, y: staticY!)
        
        if translatePoint.x > (view.frame.size.width - rightOffSet)*0.5 {
            translatePoint.x = (view.frame.size.width - rightOffSet)*0.5
        }
        
        gestureRecognizer.view?.center = translatePoint
        if gestureRecognizer.state == .ended {
            
            let velocityX = 0.2*gestureRecognizer.velocity(in: view).x
            
            var finalX = translatePoint.x + velocityX
            
            if finalX > (view.frame.size.width - rightOffSet)*0.5 {
                finalX = (view.frame.size.width - rightOffSet)*0.5
            } else {
                finalX = -(view.frame.size.width - rightOffSet)*0.5
            }
            
            
            let animationDuration = abs(velocityX*0.0002) + 0.3
            
            UIView.beginAnimations("", context: nil)
            UIView.setAnimationDuration(TimeInterval(animationDuration))
            UIView.setAnimationCurve(.easeOut)
            gestureRecognizer.view?.center = CGPoint(x: finalX, y: staticY!)
            UIView.commitAnimations()
            
        }
    }
    
    //MARK: - OBSERVER
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "position" {
            guard let newKey = change?[.newKey] as? CGPoint else {
                fatalError("Could not unwrap optional content of new key")
            }
            if newKey.x == -(view.frame.size.width - rightOffSet)*0.5 {
                dismiss()
            }
        }
    }
    
    //MARK: - ACTION
    
    func dismiss()  {
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.frame.origin.x = self.rightOffSet - self.view.bounds.width
            UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal               //bring back status bar
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
}

extension BaseSideViewController {
    
    func updateContentView(_ content : UIView) {
        content.frame = contentView.bounds
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.insertSubview(content, belowSubview: dismisButton)
    }
}














