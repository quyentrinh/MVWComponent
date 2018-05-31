//
//  PullUpViewController.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 5/30/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

protocol PullUpDataSource: class {
    func viewForHeaderBar() -> UIView?
    func imageForCloseButton() -> UIImage?
}

protocol PullUpDataDelegate: class {
    func pullUpViewControllerDidDisappear()
}

class PullUpViewController: UIViewController {
    
    var topMargin : CGFloat = 60.0
    var cornerRadius : CGFloat = 10.0
    var headerHeight : CGFloat = 60.0
    
    private let extraHeight : CGFloat = 20.0
    private let buttonsize : CGFloat = 20.0
    private let padding : CGFloat = 10.0
    private var currentY : CGFloat = 0
    
    weak var datasource : PullUpDataSource?
    weak var delegate : PullUpDataDelegate?
    
    private var wrapView: UIView!
    private var headerView: UIView!
    private var contentView: UIView!
    private var dismisButton: UIButton!
    private var panGestureRecognizer: UIPanGestureRecognizer?
    private var viewController: UIViewController!
    
    init(content : UIViewController?) {
        super.init(nibName: nil, bundle: nil)
        viewController = content
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContentView()
        setupPanGestureRecognizer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func loadView() {
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        wrapView.frame = wrapViewHidenFrame()
        headerView.frame = CGRect(x: 0, y: padding, width: wrapView.xwidth() - padding*2 - buttonsize, height: headerHeight)
        dismisButton.frame = CGRect(x: headerView.xwidth() + padding, y: padding, width: buttonsize, height: buttonsize)
        contentView.frame = CGRect(x: 0, y: headerView.yy() + headerView.xheight(), width: wrapView.xwidth(), height: wrapView.xheight() - headerView.yy() - headerView.xheight() - extraHeight)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.wrapView.frame = self.wrapViewVisibleFrame()
        }) { _ in
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - UI
    
    private func setupUI() {
        view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        //wrap view
        let _wrapView = UIView()
        _wrapView.layer.cornerRadius = cornerRadius
        _wrapView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        _wrapView.clipsToBounds = true
        _wrapView.backgroundColor = .white
        view.addSubview(_wrapView)
        wrapView = _wrapView

        //header view
        let _headerView = UIView()
        _headerView.clipsToBounds = true
        _headerView.autoresizesSubviews = true
        _wrapView.addSubview(_headerView)
        headerView = _headerView
        
        //content view
        let _contentView = UIView()
        _wrapView.addSubview(_contentView)
        contentView = _contentView
        
        //dismis button
        let _button = UIButton()
        _button.addTarget(self, action: #selector(dismissButtonPress), for: .touchUpInside)
        _wrapView.addSubview(_button)
        dismisButton = _button
        
    }
    
    
    private func setupPanGestureRecognizer() {
        let _panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(_:)))
        _panGestureRecognizer.minimumNumberOfTouches = 1
        _panGestureRecognizer.maximumNumberOfTouches = 1
        wrapView.addGestureRecognizer(_panGestureRecognizer)
        panGestureRecognizer = _panGestureRecognizer
    }
    
    private func wrapViewVisibleFrame() -> CGRect {
        return CGRect(x: 0, y: topMargin, width: view.bounds.width, height: view.bounds.height - topMargin + extraHeight)
    }
    
    private func wrapViewHidenFrame() -> CGRect {
        return CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: view.bounds.height - topMargin + extraHeight)
    }
    
    //MARK: - SELECTOR
    
    @objc private func dismissButtonPress() {
        guard let completion = delegate?.pullUpViewControllerDidDisappear else {return dismissPullViewController()}
        dismissPullViewController(completion: completion)
    }
    
    @objc private func handlePanGestureRecognizer(_ gestureRecognizer: UIPanGestureRecognizer) {
        view.bringSubview(toFront: gestureRecognizer.view!)
        var translatePoint = gestureRecognizer.translation(in: gestureRecognizer.view?.superview)

        let staticX = gestureRecognizer.view?.center.x
        
        if gestureRecognizer.state == .began {
            currentY = (gestureRecognizer.view?.center.y)!
        }
        
        translatePoint = CGPoint(x: staticX!, y: currentY + translatePoint.y)
        
        if translatePoint.y < (view.frame.size.height + topMargin)*0.5 - extraHeight*0.5 {
            translatePoint.y = (view.frame.size.height + topMargin)*0.5 - extraHeight*0.5
        }
        
        gestureRecognizer.view?.center = translatePoint
        if gestureRecognizer.state == .ended {

            let velocityY = 0.2*gestureRecognizer.velocity(in: view).y
            
            var finalY = translatePoint.y + velocityY
            
            let stopPoint1 = (view.frame.size.height + topMargin)*0.5
            let stopPoint2 = view.frame.size.height
            
            if finalY < stopPoint2 || finalY < stopPoint1 {
                finalY = stopPoint1
            } else if (finalY > stopPoint2) {
                finalY = stopPoint2
            }
            

            let animationDuration = abs(velocityY*0.0002) + 0.3

            UIView.beginAnimations("", context: nil)
            UIView.setAnimationDuration(TimeInterval(animationDuration))
            UIView.setAnimationCurve(.easeOut)
            gestureRecognizer.view?.center = CGPoint(x: staticX!, y: finalY)
            UIView.commitAnimations()

        }
    }
    
    //MARK: - ACTION
    
    func loadContentView() {
        
        if let _headerview = datasource?.viewForHeaderBar() {
            _headerview.frame = headerView.bounds
            headerView.addSubview(_headerview)
        }
        
        if let image = datasource?.imageForCloseButton() {
            dismisButton.setImage(image, for: .normal)
        }
        
        addChildViewController(viewController)
        let frame = contentView.bounds
        viewController.view.frame = frame
        contentView.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
    
    func dismissPullViewController(completion: (() -> Swift.Void)? = nil) {
        UIView.animate(withDuration: 0.3, animations: {
            self.wrapView.frame.origin.y = self.view.bounds.height
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }, completion: { _ in
            self.dismiss(animated: false, completion: completion)
        })
        
    }
    
}
