//
//  MenuViewController.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 5/31/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate: class {
    func menuView(_ menu: MenuViewController, didTapRowAt index: Int)
    func menuView(_ menu: MenuViewController, didTapSectionAt index: Int)
    func menuView(_ menu: MenuViewController, didTapIconIn section: Int, At index: Int)
    func menuViewDidDisappear()
}

class MenuViewController: BaseSideViewController {
    
    weak var delegate: MenuViewControllerDelegate?
    
    private lazy var tableView: ExpyTableView = {
        let _tableView = ExpyTableView()
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.separatorStyle = .none
        _tableView.register(MenuCell.nib, forCellReuseIdentifier: MenuCell.identifier)
        _tableView.register(MenuHeaderCell.self, forCellReuseIdentifier: MenuHeaderCell.identifier)
        
        let head =  Bundle.main.loadNibNamed("MenuHeaderView", owner: nil, options: nil)?.first as? UIView
        _tableView.tableHeaderView = head
        
        return _tableView
    }()

    var viewModel : MenuViewModel! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        viewModel.reloadSections = { [weak self] section in
            guard let sself = self else { return }
            sself.tableView.beginUpdates()
            sself.tableView.reloadSections([section], with: .automatic)
            sself.tableView.endUpdates()
        }
        
        viewModel.menuDidTapAtSection = { [weak self] section in
            guard let sself = self else { return }
            sself.dismiss { [weak self] in
                guard let ssself = self else { return }
                if let action = ssself.delegate?.menuView(ssself, didTapSectionAt: section) {
                    action
                }
            }
        }
        
        viewModel.menuDidTapAtImage = { [weak self] (section, index) in
            guard let sself = self else { return }
            sself.dismiss { [weak self] in
                guard let ssself = self else { return }
                if let action = ssself.delegate?.menuView(ssself, didTapIconIn: section, At: index) {
                    action
                }
            }
        }

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let tableViewHeader = self.tableView.tableHeaderView {
            tableViewHeader.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 90.0)
            tableView.reloadData()
        }
    }
    
    
    //MARK: - SETUP UI
    func setupUI() {
        tableView.frame = contentView.bounds
        tableView.frame.origin.y -= 20            //height of status bar
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(tableView)
    }
    
    //MARK: - Help
    func menuIndexFor(indexPath : IndexPath) -> Int {
        var index = 0
        for i in 0..<indexPath.section {
            index += tableView.numberOfRows(inSection: i)
        }
        return index + indexPath.row
    }
    
    //MARK: - Override
    override func dismissButtonPress() {
        dismiss { [weak self] in
            guard let sself = self else { return }
            if let action = sself.delegate?.menuViewDidDisappear() {
                action
            }
        }
    }
    
    override func dismiss(completion: (() -> Void)?) {
        super.dismiss(completion: completion)
    }
    
}


extension MenuViewController: ExpyTableViewDataSource {
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MenuHeaderCell.self)) as! MenuHeaderCell
        cell.updateCell()
        return cell
    }
}



extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
        return viewModel.numberOfSection()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
//        return viewModel.numberOfRowIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
//        return viewModel.heightForRow(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let model = viewModel.cellModelFor(indexPath: indexPath) else {
//            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
//            return cell
//        }
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.identifier) as! MenuCell
//        cell.titleLabel.text = model.title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss { [weak self] in
            guard let sself = self else { return }
            if let action = sself.delegate?.menuView(sself, didTapRowAt: (sself.menuIndexFor(indexPath: indexPath))) {
                action
            }
        }
    }
}



