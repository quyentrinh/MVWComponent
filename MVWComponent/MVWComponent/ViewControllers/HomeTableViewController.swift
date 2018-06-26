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
        
        let emptyCell = MenuCellModel(title: "空の")
        
        let schedule = MenuSectionModel(title: "映画館を探す", icon: "ic_mn_schedule")
        schedule.cellModel = [emptyCell]
        
        let history = MenuSectionModel(title: "閲覧履歴", icon: "ic_mn_rekisiki")
        history.cellModel = [emptyCell]
        
        let setting = MenuSectionModel(title: "設定", icon: "ic_mn_setting")
        let accountInfo = MenuSectionModel(title: "アカウント情報", withType: .textH2)
        let notificaton = MenuSectionModel(title: "プッシュ通知・お知らせの設定", withType: .textH2)
        
        let help = MenuSectionModel(title: "ヘルプ・お問い合わせ", icon: "ic_mn_help")
        help.cellModel = [emptyCell]
        
        let mitaiRecommend = MenuSectionModel(title: "Mitaiをおすすめする", withType: .textH1)
        let social1 = MenuSectionModel(images: ["ic_mn_twitter", "ic_mn_line", "ic_mn_facebook", "ic_mn_google"])
        
        let review = MenuSectionModel(title: "アプリのレビューを書く", icon: "ic_mn_review")
        review.cellModel = [emptyCell]
        
        let officalAccount = MenuSectionModel(title: "公式アカウント", withType: .textH1)
        let social2 = MenuSectionModel(images: ["ic_mn_twitter", "ic_mn_facebook"])
        let logout = MenuSectionModel(title: "ログアウト", withType: .textH3)
        
        let blank10 = MenuSectionModel(height: 10.0)
        let blank20 = MenuSectionModel(height: 20.0)
        
        let menuModel = MenuModel(sections: [blank10, schedule, history, setting, accountInfo, notificaton, help, blank10,
                                             mitaiRecommend, blank10, social1, review, blank10,
                                             officalAccount, blank10, social2, blank20,
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




