//
//  MenuViewController.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 5/31/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate: class {
    func menuView(_ menu: MenuViewController, didTapRowAt Index: Int)
    func menuView(_ menu: MenuViewController, didTapIconIn section: Int, At index: Int)
    func menuViewDidDisappear()
}

class MenuViewController: BaseSideViewController {
    
    weak var delegate: MenuViewControllerDelegate?
    
    private lazy var tableView: UITableView = {
        let _tableView = UITableView()
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.separatorStyle = .none
        _tableView.register(UINib(nibName: "MenuTextCell", bundle: nil), forCellReuseIdentifier: "menutextcell")
        _tableView.register(UINib(nibName: "MenuImageCell", bundle: nil), forCellReuseIdentifier: "menuimagecell")
        _tableView.register(UINib(nibName: "MenuTitleIconCell", bundle: nil), forCellReuseIdentifier: "menutitleiconcell")
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
    
    //MARK: - SETUP UI
    func setupUI() {
        tableView.frame = contentView.bounds
        tableView.frame.origin.y -= 20            //height of status bar
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.insertSubview(tableView, belowSubview: dismisButton)
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

extension MenuViewController {
    
}


extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel.viewForHeaderIn(section: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderIn(section: section);
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel.cellModelFor(indexPath: indexPath) else {
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
            return cell
        }
        
        switch model.type {
        case .text: do {
            let cell = tableView.dequeueReusableCell(withIdentifier: model.type.identifier) as! MenuTextCell
            cell.titleLabel.text = model.text
            return cell
            }
        case .image: do {
            let cell = tableView.dequeueReusableCell(withIdentifier: model.type.identifier) as! MenuImageCell
            cell.delegate = self
            cell.section = indexPath.section
            cell.images = model.images
            return cell
            }
        case .both: do {
            let cell = tableView.dequeueReusableCell(withIdentifier: model.type.identifier) as! MenuTitleIconCell
            cell.titleLabel.text = model.text
            return cell
            }
        }
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


extension MenuViewController: MenuImageCellDelegate {

    func imageCell(_ cell: MenuImageCell, didTapImageIn section: Int, At index: Int) {
        dismiss { [weak self] in
            guard let sself = self else { return }
            if let action = sself.delegate?.menuView(sself, didTapIconIn: section, At: index) {
                action
            }
        }
    }
    
}

