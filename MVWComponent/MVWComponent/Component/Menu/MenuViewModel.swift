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
            return sections.count + 1
        }
        return 1 //Big header
    }
    
    func numberOfRowIn(section: Int) -> Int {
        if section == 0 {
            return 0
        }
        guard let sectionData = model.sections![section-1] else { return 0 }
        if sectionData.isExpanded {
            if let cellModel = sectionData.cellModel {
                return cellModel.count
            }
        }
        return 0
    }
    
    func viewForHeaderIn(section: Int) -> UIView? {
        if section == 0 {
            return Bundle.main.loadNibNamed("MenuHeaderView", owner: nil, options: nil)?.first as? UIView
        } else {
            guard let sectionData = model.sections![section-1] else {
                return nil
            }
            let headerView = MenuSectionView(model: sectionData)
            headerView.section = section
            headerView.delegate = self
            headerView.setHeaderExpand(flag: sectionData.isExpanded)
            return headerView
        }
    }
    
    func heightForHeaderIn(section: Int) -> CGFloat {
        if section == 0 {
            return topHeaderHeight
        }
        guard let sectionData = model.sections![section-1] else {
            return 0.0
        }
        if sectionData.type! == .blank {
            return sectionData.height!
        }
        return headerHeight
    }
    
    func heightForRow(indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func cellModelFor(indexPath : IndexPath) -> MenuCellModel? {
        if let cellModel = model.sections?[indexPath.section - 1]?.cellModel {
            return cellModel[indexPath.row]
        }
        return nil
    }
    
    
    
    //MARK:- Private method
    
}


extension MenuViewModel: MenuSectionViewDelegate {
    func menuSection(header: MenuSectionView, didTapAt section: Int) {
        guard let sectionData = model.sections![section-1] else { return }
        
        if sectionData.isExpandable {
            let expand = sectionData.isExpanded
            sectionData.isExpanded = !expand
            header.setHeaderExpand(flag: !expand)
            reloadSections!(section)
        } else {
            menuDidTapAtSection!(section)
        }
    }
    
    func menuSection(header: MenuSectionView, didTapImageIn section: Int, At index: Int) {
        menuDidTapAtImage!(section, index)
    }
    
}


