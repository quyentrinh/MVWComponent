//
//  HomeTableViewController.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/8/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func menuButtonTapped(_ sender: Any) {
        
        let section1 = MenuSectionModel(headingTitle: "Akatsuki")
        let cellModel11 = MenuCellModel(title: "Nagato Uzumaki")
        let cellModel12 = MenuCellModel(title: "Itachi Uchiha")
        let cellModel13 = MenuCellModel(title: "Orochimaru")
        let cellModel14 = MenuCellModel(title: "Sasori")
        section1.cellModel = [cellModel11, cellModel12, cellModel13, cellModel14]
        
        
        let section2 = MenuSectionModel(title: "Gintama", icon: "StarEmpty")
        let cellModel21 = MenuCellModel(title: "Okita")
        let cellModel22 = MenuCellModel(title: "Katsura")
        section2.cellModel = [cellModel21, cellModel22]
        
        let section3 = MenuSectionModel(title: "One Piece", icon: "StarFull_Gray")
        let cellModel31 = MenuCellModel(title: "Monkey.D.luffy")
        let cellModel32 = MenuCellModel(title: "Ronoroa Zoro")
        let cellModel33 = MenuCellModel(title: "Sanji")
        section3.cellModel = [cellModel31, cellModel32, cellModel33]
        
        let section4 = MenuSectionModel(title: "Saitama", icon: "StarFull_Blue")
        
        let section5 = MenuSectionModel(title: "Sign Out")
        
        let section6 = MenuSectionModel(title: "Gintoki", icon: "ic_unlike")
        
        let section7 = MenuSectionModel(images: ["StarEmpty", "ic_like", "StarFull_Blue", "ic_unlike"])
        
        let menuModel = MenuModel(sections: [section1, section2, section3, section4, section7, section6, section5])
        
        let viewModel = MenuViewModel(model: menuModel)
        let vc = MenuViewController()
        vc.viewModel = viewModel
        vc.delegate = self
        showMenu(vc)
    }
    
}

extension HomeTableViewController: MenuViewControllerDelegate {
    func menuViewDidDisappear() {
        print("Menu dismissed")
    }
    
    func menuView(_ menu: MenuViewController, didTapSectionAt index: Int) {
        print("Section \(index) Tapped")
    }
    
    func menuView(_ menu: MenuViewController, didTapRowAt index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DEMO")
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func menuView(_ menu: MenuViewController, didTapIconIn section: Int, At index: Int) {
        print("Image \(section)-\(index) Tapped")
    }
    
}




