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
    
    init(model _model: MenuModel) {
        model = _model
    }
    
    //MARK:- Public method
    
    func numberOfSection() -> Int {
        if let sections = model.data {
            return sections.count
        }
        return 0
    }
    
    func numberOfRowIn(section: Int) -> Int {
        if let sectiondata = model.data[section] {
            return sectiondata.count
        }
        return 0
    }
    
    func viewForHeaderIn(section: Int) -> UIView? {
        var nibName = MenuHeaderType.normal.nib
        if section == 0 {
            nibName = model.headerType.nib
        }
        if let nib = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? UIView {
            return nib
        }
        return nil
    }
    
    func heightForHeaderIn(section: Int) -> CGFloat {
        if section == 0 {
            return 80
        }
        return 30
    }
    
    func cellModelFor(indexPath : IndexPath) -> MenuCellModel? {
        guard let model = model.data[indexPath.section]![indexPath.row] else {
            return nil
        }
        return model
    }
    

    
    //MARK:- Private method
    
}

