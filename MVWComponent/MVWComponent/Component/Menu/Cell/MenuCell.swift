//
//  MenuCell.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/7/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
