//
//  ReviewBar.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/6/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

protocol ReviewBarDelegate: class {
    func reviewBar(_ segmentbar: ReviewBar, didSelectItemAt Index: Int)
}

@IBDesignable
class ReviewBar: UIView {

    let nibName = "ReviewBar"
    var contentView : UIView?
    
    weak var delegate : ReviewBarDelegate?
    
    //MARK:- SETUP
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    
    
    func xibSetup() {
        if contentView == nil {
            
            contentView = loadViewFromNib()
            
            contentView!.frame = bounds
            
            contentView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            addSubview(contentView!)
        }
        
        updateUI()
        
    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    //MARK:- ACTION
    
    func updateUI() {

    }

}
