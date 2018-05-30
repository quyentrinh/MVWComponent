//
//  PullUpViewController.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 5/30/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class PullUpViewController: UIViewController {
    
    var topMargin : CGFloat = 60.0
    var cornerRadius : CGFloat = 10.0
    
    private let buttonsize : CGFloat = 20.0
    
    private var wrapView: UIView!
    private var headerView: UIView!
    private var contentView: UIView!
    private var dismisButton: UIButton!
    private var viewController: UIViewController!
    
    init( _viewController : UIViewController?) {
        super.init(nibName: nil, bundle: nil)
        viewController = _viewController
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContentView()
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
        UIView.animate(withDuration: 0.3, animations: {
            self.wrapView.frame = self.wrapViewVisibleFrame()
            self.view.layoutIfNeeded()
        }) { finish in

            self.headerView.frame = CGRect(x: 0, y: 10, width: self.wrapView.xwidth() - 10*2 - self.buttonsize, height: 60.0)
            self.dismisButton.frame = CGRect(x: self.headerView.xwidth() + 10, y: 10, width: self.buttonsize, height: self.buttonsize)
            self.contentView.frame = CGRect(x: 0, y: self.headerView.yy() + self.headerView.xheight(), width: self.wrapView.xwidth(), height: self.wrapView.xheight() - self.headerView.yy() - self.headerView.xheight())
        }
    }
    
    override func viewDidLayoutSubviews() {
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
        _headerView.backgroundColor = .yellow
        _wrapView.addSubview(_headerView)
        headerView = _headerView
        
        //content view
        let _contentView = UIView()
        _contentView.backgroundColor = .white
        _wrapView.addSubview(_contentView)
        contentView = _contentView
        
        //dismis button
        let _button = UIButton()
        _button.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0.8549019608, blue: 0.9019607843, alpha: 1)
        _button.setTitle("x", for: .normal)
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
    
    func loadContentView() {
        addChildViewController(viewController)
        let frame = contentView.bounds
        viewController.view.frame = frame
        contentView.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
    
    func dismissPullViewController() {
        UIView.animate(withDuration: 0.3, animations: {
            self.wrapView.frame.origin.y = self.view.bounds.height
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
        })
        
    }
    
    @objc func dismissButtonPress() {
        dismissPullViewController()
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
