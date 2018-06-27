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
        
        let emptyCell = MenuCellModel(title: "ルプ・0")
        let emptyCell1 = MenuCellModel(title: "ルプ・1")
        let emptyCell2 = MenuCellModel(title: "ルプ・2")
        let emptyCell3 = MenuCellModel(title: "ルプ・3")
        let emptyCell4 = MenuCellModel(title: "ルプ・4")
        let emptyCell5 = MenuCellModel(title: "ルプ・5")
        let emptyCell6 = MenuCellModel(title: "ルプ・6")
        let emptyCell7 = MenuCellModel(title: "ルプ・7")
        let emptyCell8 = MenuCellModel(title: "ルプ・8")
        let emptyCell9 = MenuCellModel(title: "ルプ・9")
        
        let schedule = MenuSectionModel(title: "映画館を探す", icon: "ic_unlike")
//        schedule.cellModel = [emptyCell, emptyCell1]
        
        let history = MenuSectionModel(title: "閲覧履歴", icon: "ic_unlike")
        history.cellModel = [emptyCell, emptyCell1, emptyCell2]
        
        let setting = MenuSectionModel(title: "設定", icon: "ic_unlike")
        setting.cellModel = [emptyCell3, emptyCell4]
        
        let accountInfo = MenuSectionModel(title: "アカウント情報", withType: .textH2)
        let notificaton = MenuSectionModel(title: "プッシュ通知・お知らせの設定", withType: .textH2)
        
        let help = MenuSectionModel(title: "ヘルプ・お問い合わせ", icon: "ic_unlike")
        help.cellModel = [emptyCell5, emptyCell6, emptyCell7]
        
        let mitaiRecommend = MenuSectionModel(title: "Mitaiをおすすめする", withType: .textH1)
        let social1 = MenuSectionModel(images: ["ic_unlike", "ic_unlike", "ic_unlike", "ic_unlike"])
        
        let review = MenuSectionModel(title: "アプリのレビューを書く", icon: "ic_unlike")
        review.cellModel = [emptyCell8, emptyCell9]
        
        let officalAccount = MenuSectionModel(title: "公式アカウント", withType: .textH1)
        let social2 = MenuSectionModel(images: ["ic_unlike", "ic_unlike"])
        let logout = MenuSectionModel(title: "ログアウト", withType: .textH3)
        
        let blank10 = MenuSectionModel(height: 10.0)
        let blank20 = MenuSectionModel(height: 20.0)
        
        let menuModel = MenuModel(sections: [accountInfo, schedule, notificaton, help, history, setting ,
                                             mitaiRecommend, social1, review,
                                             officalAccount, social2,
                                             logout])
        
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




