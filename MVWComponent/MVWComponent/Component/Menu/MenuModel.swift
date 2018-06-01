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
}

class MenuModel: NSObject {
    var data : [MenuCellModel]!
    
    init(data _data: [MenuCellModel]) {
        data = _data
    }
    
}


class MenuCellModel: NSObject {
    var type : MenuCellType!
    var text : String!
    var iconName : String!
    var images : [String]!
    
    init(text _text: String) {
        super.init()
        text = _text
        type = .text
    }
    
    init(icon _iconName:String, text _text:String) {
        super.init()
        text = _text
        iconName = _iconName
        type = .both
    }
    
    init(images _images: [String]) {
        super.init()
        images = _images
        type = .image
    }
    
}
