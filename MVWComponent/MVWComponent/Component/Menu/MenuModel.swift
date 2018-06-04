//
//  MenuModel.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/1/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

enum MenuCellType {
    case text
    case image
    case both
    
    var nib: String {
        switch self {
        case .text:
            return "MenuTextCell"
        case .image:
            return "MenuImageCell"
        case .both:
            return "MenuTitleIconCell"
        }
    }
    var identifier: String {
        switch self {
        case .text:
            return "menutextcell"
        case .image:
            return "menuimagecell"
        case .both:
            return "menutitleiconcell"
        }
    }
}

enum MenuHeaderType {
    case one
    case two
    case three
    case normal
    
    var nib: String {
        switch self {
        case .one:
            return "Type1HeaderView"
        case .two:
            return "Type2HeaderView"
        case .three:
            return "Type3HeaderView"
        case .normal:
            return  "NormalHeaderView"
        }
    }
}

class MenuModel {
    var data : [[MenuCellModel?]?]!
    var headerType : MenuHeaderType
    
    init(data _data: [[MenuCellModel]], headerType _type: MenuHeaderType) {
        data = _data
        headerType = _type
    }
    
}


class MenuCellModel {
    var type : MenuCellType
    var text : String!
    var iconName : String!
    var images : [String]!
    
    init(text _text: String) {
        text = _text
        type = .text
    }
    
    init(icon _iconName:String, text _text:String) {
        text = _text
        iconName = _iconName
        type = .both
    }
    
    init(images _images: [String]) {
        images = _images
        type = .image
    }
    
}
