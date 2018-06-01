//
//  RatingView.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/1/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

@IBDesignable
class RatingView: UIView {

    @IBOutlet weak var rating: FloatRatingView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var valueSlider: RatingSlider!
    
    @IBInspectable open var hasSlider: Bool = false {
        didSet {
            valueSlider.isHidden = !hasSlider
            xibSetup()
        }
    }
    
    @IBInspectable open var darkStar: Bool = false
    
    let nibName = "RatingView"
    var contentView : UIView?
    
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
        rating.type = .floatRatings
        rating.editable = false
        let imageName = darkStar ? "StarFull_Gray" : "StarFull_Blue"
        rating.fullImage = UIImage(named: imageName)
    }
    
    
    
    func xibSetup() {
        
        contentView = loadViewFromNib()

        contentView!.frame = bounds

        contentView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
        addSubview(contentView!)
        
    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        valueLabel.text = String(format: "%.1f", sender.value)
        rating.rating = Double(sender.value)
    }
    
}

