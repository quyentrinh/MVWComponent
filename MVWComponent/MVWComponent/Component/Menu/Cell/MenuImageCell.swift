//
//  MenuImageCell.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/4/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

protocol MenuImageCellDelegate: class {
    func imageCell(_ cell: MenuImageCell, didTapImageIn section: Int, At index: Int)
}

class MenuImageCell: UITableViewCell {

    private let imageSize: CGFloat = 30.0
    private let padding: CGFloat = 15.0
    private let tagOffset: Int = 100
    
    var section: Int!
    weak var delegate: MenuImageCellDelegate?
    
    var images : [String]! {
        didSet {
            updateLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateLayout() {
        if let _images = images {
            for i in 0..<_images.count {
                let positionX = (imageSize + padding)*CGFloat(i) + padding
                let imageView = UIImageView(frame: CGRect(x: positionX, y: (contentView.frame.height - imageSize)/2, width: imageSize, height: imageSize))
                imageView.backgroundColor = .groupTableViewBackground
                imageView.tag = i + tagOffset
                imageView.image = UIImage(named: _images[i])
                imageView.isUserInteractionEnabled = true
                let recognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapRecognizer(_:)))
                imageView.addGestureRecognizer(recognizer)
                
                contentView.addSubview(imageView)
            }
        }
    }
    
    @objc func imageTapRecognizer(_ recognizer: UITapGestureRecognizer) {
        let image = recognizer.view as! UIImageView
        let index = image.tag - tagOffset
        if let action = delegate?.imageCell(self, didTapImageIn: section, At: index) {
            action
        }
    }
    
}
