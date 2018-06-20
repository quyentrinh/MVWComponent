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
        let picker = PickerView(data: [], type: .booking)
        picker.delegate = self
        picker.show()
    }
    

}

extension PickerDemoVC: PickerViewDelegate {
    func pickerView(_ picker: PickerView, didSelected value: String?, at index: Int) {
        print("\(String(describing: value!)) - at \(index)")
    }
}
