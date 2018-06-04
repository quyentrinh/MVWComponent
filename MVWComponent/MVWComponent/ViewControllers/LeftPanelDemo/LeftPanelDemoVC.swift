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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showButtonTapped(_ sender: Any) {
        
        var cellModels = Array<[MenuCellModel]>()
        
        let cell11 = MenuCellModel(text: "Quyen Trinh Van")
        let cell12 = MenuCellModel(images: [])
        let cell13 = MenuCellModel(icon: "", text: "Gintoki san")
        let section1 = [cell11, cell12, cell13]
        
        let cell22 = MenuCellModel(images: [])
        let cell23 = MenuCellModel(icon: "", text: "Tasumaki")
        let section2 = [cell22, cell23]
        
        
        let cell31 = MenuCellModel(images: [])
        let cell32 = MenuCellModel(text: "Log out")
        let section3 = [cell31, cell32]
        
        
        
        cellModels.append(section1)
        cellModels.append(section2)
        cellModels.append(section3)
        
        let model = MenuModel(data: cellModels, headerType: .one)
        
        let viewModel = MenuViewModel(model: model)
        
        let vc = MenuViewController()
        vc.viewModel = viewModel
        showMenu(vc)
    }

    
    
}
