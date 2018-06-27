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
    
    var reloadSections: ((_ section: Int) -> Void)?
    var menuDidTapAtSection: ((_ section: Int) -> Void)?
    var menuDidTapAtImage: ((_ section: Int, _ index: Int) -> Void)?
    
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
    
    func headerViewFor(tableView: UITableView, section: Int) -> MenuHeaderCell {
        guard let sectionData = model.sections?[section] else {
            return MenuHeaderCell(style: .default, reuseIdentifier: MenuHeaderCell.identifier)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuHeaderCell.identifier) as! MenuHeaderCell
        if let cellsection = cell.section, cellsection == section {
            return cell
        }
        cell.updateHeader(model: sectionData)
        cell.section = section
        return cell
    }
    
    func cellFor(tableView: UITableView, indexPath: IndexPath) -> MenuCell {
        guard let cellModel = model.sections?[indexPath.section]?.cellModel?[indexPath.row-1] else {
            return MenuCell(style: .default, reuseIdentifier: MenuCell.identifier)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.identifier) as! MenuCell
        cell.titleLabel.text = cellModel.title
        return cell
    }
    
    func heightForHeaderIn(section: Int) -> CGFloat {
        guard let sectionData = model.sections![section-1] else {
            return 0.0
        }
        if sectionData.type! == .blank {
            return sectionData.height!
        }
        return headerHeight
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
    
    
    //MARK:- Private method
    
}


//extension MenuViewModel: MenuHeaderViewDelegate {
//    func menuSection(header: MenuHeaderView, didTapAt section: Int) {
//        guard let sectionData = model.sections![section-1] else { return }
//        
//        if sectionData.isExpandable {
//            let expand = sectionData.isExpanded
//            sectionData.isExpanded = !expand
//            header.setHeaderExpand(flag: !expand)
//            reloadSections!(section)
//        } else {
//            menuDidTapAtSection!(section)
//        }
//    }
//    
//    func menuSection(header: MenuSectionView, didTapImageIn section: Int, At index: Int) {
//        menuDidTapAtImage!(section, index)
//    }
//    
//}


