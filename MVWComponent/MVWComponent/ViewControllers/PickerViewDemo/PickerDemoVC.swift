//
//  PickerDemoVC.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/20/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class PickerDemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showPickerTapped(_ sender: Any) {
        let picker = PickerView(data: [], type: .normal)
        picker.show()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
