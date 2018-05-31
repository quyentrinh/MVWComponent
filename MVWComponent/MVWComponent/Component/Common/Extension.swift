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
