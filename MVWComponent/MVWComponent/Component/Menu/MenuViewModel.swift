//
//  MenuViewModel.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/1/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit



class MenuViewModel {
    
    private var model : MenuModel!
    
    var reloadSections: ((_ section: Int) -> Void)?
    
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
            let headerView : MenuSectionView
            switch sectionData.type! {
            case .onlyText:
                headerView = MenuSectionView(title: sectionData.title!, frame: .zero)
                break
            case .textHeading:
                headerView = MenuSectionView(headingTitle: sectionData.title!, frame: .zero)
                break
            case .imageGroup:
                headerView = MenuSectionView(images: sectionData.imagesName!, frame: .zero)
                break
            case .iconText:
                headerView = MenuSectionView(title: sectionData.title!, icon: sectionData.iconName!, frame: .zero)
                break
            }
            
            headerView.section = section
            headerView.delegate = self
            return headerView
        }
    }
    
    func heightForHeaderIn(section: Int) -> CGFloat {
        if section == 0 {
            return 80
        }
        return 40
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
    func toggleSection(header: MenuSectionView, section: Int) {
        if let sectionData = model.sections![section-1], sectionData.isExpandable {
            let expand = sectionData.isExpanded
            sectionData.isExpanded = !expand
            reloadSections!(section)
        }
    }
    
    
}

