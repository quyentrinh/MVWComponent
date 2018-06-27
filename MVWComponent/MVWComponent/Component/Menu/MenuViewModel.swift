//
//  MenuViewModel.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/1/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit



class MenuViewModel {
    
    private let topHeaderHeight: CGFloat = 90
    private let headerHeight: CGFloat = 40
    
    private var model : MenuModel!
    
    init(model _model: MenuModel) {
        model = _model
    }
    
    //MARK:- Public method
    
    func numberOfSection() -> Int {
        if let sections = model.sections {
            return sections.count
        }
        return 0
    }
    
    func numberOfRowIn(section: Int) -> Int {
        guard let sectionData = model.sections?[section] else { return 0 }
        if let cellModel = sectionData.cellModel {
                return cellModel.count + 1
        }
        return 1
    }
    
    func headerViewFor(tableView: UITableView, section: Int) -> UITableViewCell? {
        guard let sectionData = model.sections?[section] else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let cell: MenuHeaderCell?
        switch sectionData.type! {
        case .iconText:
            cell = tableView.dequeueReusableCell(withIdentifier: IconTextHeaderCell.identifier) as! IconTextHeaderCell
        case .imageGroup:
            cell = tableView.dequeueReusableCell(withIdentifier: ImageGroupHeaderCell.identifier) as! ImageGroupHeaderCell
        case .textH1:
            cell = tableView.dequeueReusableCell(withIdentifier: H1TextHeaderCell.identifier) as! H1TextHeaderCell
        case .textH2:
            cell = tableView.dequeueReusableCell(withIdentifier: H2TextHeaderCell.identifier) as! H2TextHeaderCell
        case .textH3:
            cell = tableView.dequeueReusableCell(withIdentifier: H3TextHeaderCell.identifier) as! H3TextHeaderCell
        case .blank:
            cell = tableView.dequeueReusableCell(withIdentifier: BlankHeaderCell.identifier) as! BlankHeaderCell
        }
        guard let _cell = cell else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        _cell.updateDisplay(model: sectionData)
        _cell.section = section
        return _cell
    }
    
    func cellFor(tableView: UITableView, indexPath: IndexPath) -> MenuCell {
        guard let cellModel = model.sections?[indexPath.section]?.cellModel?[indexPath.row-1] else {
            return MenuCell(style: .default, reuseIdentifier: MenuCell.identifier)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.identifier) as! MenuCell
        cell.titleLabel.text = cellModel.title
        return cell
    }
    
    
    func heightForRow(indexPath: IndexPath) -> CGFloat {
        guard let sectionData = model.sections![indexPath.section] else {
            return 0.0
        }
        if sectionData.type! == .blank {
            return sectionData.height!
        }
        return headerHeight
    }
    
    func isExpandable(section: Int) -> Bool {
        guard let sectionData = model.sections?[section] else {
            return false
        }
        return sectionData.isExpandable
    }
    
    
    //MARK:- Private method
    
}



