//
//  MenuViewController.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 5/31/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class MenuViewController: BaseSideViewController {
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        let _tableView = UITableView()
        _tableView.delegate = self
        _tableView.dataSource = self
        updateContentView(_tableView)
        tableView = _tableView
    }
    
}


extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

