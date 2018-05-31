//
//  MenuViewController.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 5/31/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    
    var rightOffSet: CGFloat = 80.0
    
    private let statusbarHeight : CGFloat = 20.0
    private let buttonsize : CGFloat = 20.0
    private let padding : CGFloat = 5.0
    private var currentX : CGFloat = 0
    
    private var contentView: UIView!
//    private var tableView: UITableView!
    private var dismisButton: UIButton!
    private var panGestureRecognizer: UIPanGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        contentView.frame = contentViewHidenFrame()
//        tableView.frame = CGRect(x: 0, y: statusbarHeight, width: contentView.xwidth(), height: contentView.xheight() - statusbarHeight)
        dismisButton.frame = CGRect(x: contentView.xwidth() - buttonsize - padding*2, y: statusbarHeight + padding, width: buttonsize, height: buttonsize)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.frame = self.contentViewVisibleFrame()
        }) { _ in
            self.view.layoutIfNeeded()
            self.contentView.layer.addObserver(self, forKeyPath: "position", options: .new, context: nil)
        }
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
        
        // tableview
//        let _tableView = UITableView()
//        contentView.addSubview(_tableView)
//        tableView = _tableView
        
        //dismis button
        let _button = UIButton()
        _button.addTarget(self, action: #selector(dismissButtonPress), for: .touchUpInside)
        _button.backgroundColor = .black
        contentView.addSubview(_button)
        dismisButton = _button
    }
    
    private func setupPanGestureRecognizer() {
        let _panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(_:)))
        _panGestureRecognizer.minimumNumberOfTouches = 1
        _panGestureRecognizer.maximumNumberOfTouches = 1
        contentView.addGestureRecognizer(_panGestureRecognizer)
        panGestureRecognizer = _panGestureRecognizer
    }
    
    private func contentViewVisibleFrame() -> CGRect {
        return CGRect(x: 0, y: 0, width: view.bounds.width - rightOffSet, height: view.bounds.height)
    }
    
    private func contentViewHidenFrame() -> CGRect {
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
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
        })
    }

}

//extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return nil
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
//}

extension MenuViewController {

    
    
}
