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
        _tableView.register(IconTextHeaderCell.self, forCellReuseIdentifier: IconTextHeaderCell.identifier)
        _tableView.register(H1TextHeaderCell.self, forCellReuseIdentifier: H1TextHeaderCell.identifier)
        _tableView.register(H2TextHeaderCell.self, forCellReuseIdentifier: H2TextHeaderCell.identifier)
        _tableView.register(H3TextHeaderCell.self, forCellReuseIdentifier: H3TextHeaderCell.identifier)
        _tableView.register(ImageGroupHeaderCell.self, forCellReuseIdentifier: ImageGroupHeaderCell.identifier)
        _tableView.register(BlankHeaderCell.self, forCellReuseIdentifier: BlankHeaderCell.identifier)
        
        let head =  Bundle.main.loadNibNamed("MenuHeaderView", owner: nil, options: nil)?.first as? UIView
        _tableView.tableHeaderView = head
        
        _tableView.estimatedRowHeight = 0
        _tableView.estimatedSectionHeaderHeight = 0
        _tableView.estimatedSectionFooterHeight = 0
        
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
        let headerCell = viewModel.headerViewFor(tableView: tableView, section: section)
        if let cell = headerCell as? MenuHeaderCell {
            cell.delegate = self
        }
        return headerCell!
    }
}



extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellFor(tableView: tableView, indexPath: indexPath)
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        dismiss { [weak self] in
//            guard let sself = self else { return }
//            if let action = sself.delegate?.menuView(sself, didTapRowAt: (sself.menuIndexFor(indexPath: indexPath))) {
//                action
//            }
//        }
//    }
}

extension MenuViewController: ExpyTableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if !viewModel.isExpandable(section: indexPath.section) {
            dismiss { [weak self] in
                guard let sself = self else { return }
                if let action = sself.delegate?.menuView(sself, didTapSectionAt: indexPath.section) {
                    action
                }
            }
        } else {
            if indexPath.row != 0 {
                
                dismiss { [weak self] in
                    guard let sself = self else { return }
                    if let action = sself.delegate?.menuView(sself, didTapRowAt: indexPath.row) {
                        action
                    }
                }
            }
        }
    }
}

extension MenuViewController: MenuHeaderViewDelegate {
    func menuHeader(_ header: MenuHeaderCell, didTapImageIn section: Int, At index: Int) {
        if let action = delegate?.menuView(self, didTapIconIn: section, At: index) {
            action
        }
    }
    
    
}




