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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let segment = SegmentBarView(frame: CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 30))
        segment.delegate = self
        segment.datasource = self
        view.addSubview(segment)
        
        ratingViewWithoutSlideer.ratingValue = 4.7
        print("rating : \(ratingView.ratingValue)")
        
//        let tagviewConfig = TagConfiguration(backgroundColor: .groupTableViewBackground,
//                                             selectedBackgroundColor: .lightGray,
//                                             borderColor: .brown, borderWidth: 0.8,
//                                             cornerRadius: 5.0,
//                                             padding: 5.0,
//                                             textColor: .darkGray,
//                                             font: .systemFont(ofSize: 13)
//        )
//
//        let tagview = TagView(configrution: tagviewConfig, frame: CGRect(x: 20, y: 380, width: view.frame.width - 40, height: 60))
//        tagview.tagsData = ["Gintoki", "Yiru", "Okita", "Katsura", "Messi", "Cristiano"]
//        view.addSubview(tagview)
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

