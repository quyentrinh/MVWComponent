//
//  MenuModel.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/1/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit


import UIKit


class MenuModel {
    
    var sections : [MenuSectionModel?]?
    
    init(sections _sections: [MenuSectionModel]) {
        sections = _sections
    }
    
}


class MenuSectionModel {
    var title : String?
    var height : CGFloat?
    var iconName : String?
    var imagesName : [String]?
    var type: MenuHeaderType?
    var cellModel: [MenuCellModel]?
    
    var isExpanded: Bool = false
    var isExpandable: Bool {
        if let cellmodel = cellModel {
            return cellmodel.count > 0
        }
        return false
    }
    
    init(title _title: String, withType _type: MenuHeaderType) {
        type = _type
        title = _title
    }
    
    init(title _title: String, icon:String) {
        type = .iconText
        title = _title
        iconName = icon
    }
    
    init(images: [String]) {
        type = .imageGroup
        imagesName = images
    }
    
    init(height _height: CGFloat) {
        type = .blank
        height = _height
    }
    
}

class MenuCellModel {
    var title : String
    
    init(title _title: String) {
        title = _title
    }
    
}
