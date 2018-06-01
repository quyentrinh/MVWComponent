//
//  LeftPanelDemoVC.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 5/31/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class LeftPanelDemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segment = SegmentBarView(frame: CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 50))
        segment.delegate = self
        segment.datasource = self
        view.addSubview(segment)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func showButtonTapped(_ sender: Any) {
        let vc = MenuViewController()
        showMenu(vc)
    }
    
}

extension LeftPanelDemoVC : SegmentBarViewDelegate, SegmentBarViewDatasource {
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
        return CGSize(width: 60, height: 50)
    }
    
    
}
