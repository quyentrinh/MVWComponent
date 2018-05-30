//
//  PullUpViewController.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 5/30/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

protocol PullUpDataSource: class {
    func headerViewForPullUp() -> UIView?
    func imageForCloseButton() -> UIImage?
}

protocol PullUpDataDelegate: class {
    func pullUpViewControllerDidDisappear()
}

class PullUpViewController: UIViewController {
    
    var topMargin : CGFloat = 60.0
    var cornerRadius : CGFloat = 10.0
    var headerHeight : CGFloat = 60.0
    
    private let buttonsize : CGFloat = 20.0
    private let padding : CGFloat = 10.0
    
    weak var datasource : PullUpDataSource?
    weak var delegate : PullUpDataDelegate?
    
    private var wrapView: UIView!
    private var headerView: UIView!
    private var contentView: UIView!
    private var dismisButton: UIButton!
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
        contentView.frame = CGRect(x: 0, y: headerView.yy() + headerView.xheight(), width: wrapView.xwidth(), height: wrapView.xheight() - headerView.yy() - headerView.xheight())
        
        UIView.animate(withDuration: 0.3, animations: {
            self.wrapView.frame = self.wrapViewVisibleFrame()
        }) { _ in
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - UI
    
    func setupUI() {
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
    
    func wrapViewVisibleFrame() -> CGRect {
        return CGRect(x: 0, y: topMargin, width: view.bounds.width, height: view.bounds.height - topMargin)
    }
    
    func wrapViewHidenFrame() -> CGRect {
        return CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: view.bounds.height - topMargin)
    }
    
    //MARK: - ACTION
    
    @objc func dismissButtonPress() {
        guard let completion = delegate?.pullUpViewControllerDidDisappear else {return dismissPullViewController()}
        dismissPullViewController(completion: completion)
    }
    
}

extension PullUpViewController {
    
    func loadContentView() {
        
        if let _headerview = datasource?.headerViewForPullUp() {
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


extension UIViewController {
    
    open func addPullUpController(_ pullUpController: UIViewController) {
        pullUpController.modalTransitionStyle = .crossDissolve
        pullUpController.modalPresentationStyle = .overCurrentContext
        present(pullUpController, animated: true, completion: nil)
    }
    
}

private extension UIView {
    func xwidth() -> CGFloat {
        return frame.size.width
    }
    
    func xheight() -> CGFloat {
        return frame.size.height
    }
    
    func xx() -> CGFloat {
        return frame.origin.x
    }
    
    func yy() -> CGFloat {
        return frame.origin.y
    }
}
