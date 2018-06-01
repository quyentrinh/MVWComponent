//
//  Extension.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 5/31/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    open func addPullUpController(_ pullUpController: UIViewController) {
        pullUpController.modalTransitionStyle = .crossDissolve
        pullUpController.modalPresentationStyle = .overCurrentContext
        present(pullUpController, animated: true, completion: nil)
    }
    
    open func showMenu(_ pullUpController: UIViewController) {
        pullUpController.modalTransitionStyle = .crossDissolve
        pullUpController.modalPresentationStyle = .overFullScreen
        present(pullUpController, animated: true, completion: nil)
    }
    
}

extension UIView {
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

extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
