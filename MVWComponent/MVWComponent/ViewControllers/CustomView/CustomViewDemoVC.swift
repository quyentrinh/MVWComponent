//
//  CustomViewDemoVC.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/1/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class CustomViewDemoVC: UIViewController {

    
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var ratingViewWithoutSlideer: RatingView!
    @IBOutlet weak var reviewBar: ReviewBar!
    @IBOutlet weak var reviewBarItem: ReviewBarItem!
    
    
    var arrTitles : [String]!
    var arrImage : [UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let segment = SegmentBarView(frame: CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 30))
        segment.delegate = self
        segment.datasource = self
        view.addSubview(segment)
        
        ratingViewWithoutSlideer.ratingValue = 4.7
        print("rating : \(ratingView.ratingValue)")
        
        arrTitles = ["Messi | Leo", "Ronaldo", "Neymar | Jr", "Hazard"]
        arrImage = [#imageLiteral(resourceName: "ic_dismiss") , #imageLiteral(resourceName: "ic_like") ,#imageLiteral(resourceName: "StarFull_Gray") ,#imageLiteral(resourceName: "StarFull_Blue")]
        
        reviewBar.delegate = self
        reviewBar.datasource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension CustomViewDemoVC : SegmentBarViewDelegate, SegmentBarViewDatasource {
    func segmentBarView(_ segmentbar: SegmentBarView, didSelectItemAt Index: Int) {
        print("\(Index) selected.")
    }
    
    func segmentBarView(_ segmentbar: SegmentBarView, didDeselectItemAt Index: Int) {
        print("\(Index) deselected.")
    }
    
    func numberOfItems(in segmentbar: SegmentBarView) -> Int? {
        return 20
    }
    
    func segmentBarView(_ segmentbar: SegmentBarView, titleForRowAt Index: Int) -> String? {
        return "QT\n\(Index)"
    }
    
    func segmentBarView(_ segmentbar: SegmentBarView, sizeForRowAt Index: Int) -> CGSize? {
        return CGSize(width: 45, height: 30)
    }
}

extension CustomViewDemoVC: ReviewBarDelegate, ReviewBarDatasource {
    func reviewBar(_ segmentbar: ReviewBar, didSelectItemAt Index: Int) {
        print("Inden \(Index) tapped.")
    }
    
    func reviewBar(_ segmentbar: ReviewBar, titleForItemAt Index: Int) -> String? {
        return arrTitles[Index]
    }
    
    func reviewBar(_ segmentbar: ReviewBar, normalImageForItemAt Index: Int) -> UIImage? {
        return arrImage[Index]
    }
    
    func reviewBar(_ segmentbar: ReviewBar, highLightImageForItemAt Index: Int) -> UIImage? {
        return arrImage[Index]
    }
    
    func reviewBar(_ segmentbar: ReviewBar, shouldHighLightForItemAt Index: Int) -> Bool {
        if Index%2 == 1 {
            return true
        }
        return false
    }
    
    
}


