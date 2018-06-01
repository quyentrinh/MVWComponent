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

    let nibName = "RatingView"
    
    private static let blueColor = UIColor(red: 86/255.0, green: 134/255.0, blue: 237/255.0, alpha: 1.0)
    private static let darkColor = UIColor(red: 128/255.0, green: 127/255.0, blue: 127/255.0, alpha: 1.0)
    
    var contentView : UIView?
    
    var ratingValue: Double {
        get {
            return rating.rating
        }
        set(value) {
            updateRating(value: value)
        }
    }
    
    
    @IBOutlet weak var rating: FloatRatingView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var valueSlider: RatingSlider!
    
    @IBInspectable open var hasSlider: Bool = false {
        didSet {
            xibSetup()
        }
    }
    
    @IBInspectable open var darkStar: Bool = false {
        didSet {
            xibSetup()
        }
    }
    
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
        rating.type = .floatRatings
        rating.editable = false
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
        let imageName = darkStar ? "StarFull_Gray" : "StarFull_Blue"
        let color = darkStar ? RatingView.darkColor : RatingView.blueColor
        rating.fullImage = UIImage(named: imageName)
        valueLabel.textColor = color
        valueSlider.isHidden = !hasSlider
        
    }
    
    func updateRating(value: Double) {
        valueLabel.text = String(format: "%.1f", value)
        rating.rating = value
    }
    
    
    //MARK:- SELECTOR
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        updateRating(value: Double(sender.value))
    }
    
}

//extension RatingView: FloatRatingViewDelegate {
//    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
//        print("didUpdate: \(rating)")
//    }
//
//    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
//        print("isUpdating: \(rating)")
//    }
//}
















