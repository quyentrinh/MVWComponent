//
//  MenuHeaderCell.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/26/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class MenuHeaderCell: UITableViewCell {

    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private var titleLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func updateCell() {
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func commonInit() {
        selectionStyle = .none
        contentView.backgroundColor = .groupTableViewBackground
        
        let label = UILabel()
        label.textAlignment = .center
        label.text = "HEADER"
        contentView.addSubview(label)
        titleLabel = label
    }
    
    override func layoutSubviews() {
        titleLabel?.frame = contentView.bounds
    }
    
}
