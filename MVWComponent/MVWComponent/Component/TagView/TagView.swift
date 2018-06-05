//
//  TagView.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/5/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit


struct TagConfiguration {
    let backgroundColor: UIColor!
    let selectedBackgroundColor: UIColor! //.
    let borderColor: UIColor!
    let borderWidth: CGFloat!
    let cornerRadius: CGFloat!
    let padding: CGFloat!   //..
    let textColor: UIColor!
    let font: UIFont!
}

enum TagViewStyle {
    case bubble
    case box
}

class TagView: UIView {

    private var collectionView : UICollectionView!
    private static let reuseIdentify = "tagcell"
    
    var config : TagConfiguration!
    
    var tagsData: [String]! {
        willSet {
            collectionView.reloadData()
        }
    }
    
    init(configrution _config: TagConfiguration, frame: CGRect) {
        super.init(frame: frame)
        config = _config
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func updateConstraints() {
        collectionView.frame = self.bounds
        super.updateConstraints()
    }
    
    //MARK:- UI
    
    func setupUI() {
        backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        let _collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        _collectionView.backgroundColor = .white
        _collectionView.delegate = self
        _collectionView.dataSource = self
        _collectionView.showsHorizontalScrollIndicator = false
        _collectionView.showsVerticalScrollIndicator = false
        _collectionView.register(TagCell.self, forCellWithReuseIdentifier: TagView.reuseIdentify)
        addSubview(_collectionView)
        collectionView = _collectionView
        
        updateConstraintsIfNeeded()
    }

}

extension TagView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagView.reuseIdentify, for: indexPath) as! TagCell
        cell.tagConfig = config
        cell.titleLabel.text = tagsData[indexPath.row]
        return cell
    }
    
    //MARK: - Delgete
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TagCell
        cell?.updateConstraintsIfNeeded()
    }
    
    //MARK: - FlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = tagsData[indexPath.row] as NSString
        let size = text.size(withAttributes: [NSAttributedStringKey.font : config.font])
        return CGSize(width: size.width + config.padding*2, height: size.height + config.padding*2)
    }
    
}

class TagCell: UICollectionViewCell {
    
    var tagConfig: TagConfiguration! {
        didSet {
            content.configureView(tagConfig)
            titleLabel.configureLabel(tagConfig)
        }
    }
    
    var content : UIView!
    var titleLabel : UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        content = UIView()
        content.frame = self.contentView.bounds
        contentView.addSubview(content)
        titleLabel = UILabel()
        titleLabel.frame = content.bounds
        content.addSubview(titleLabel)

    }

}


private extension UIView {
    
    func configureView(_ config: TagConfiguration?) {
        if let _config = config {
            backgroundColor = _config.backgroundColor
            layer.borderColor = _config.borderColor.cgColor
            layer.borderWidth = _config.borderWidth
            layer.cornerRadius = _config.cornerRadius
        }
    }
}

private extension UILabel {
    
    func configureLabel(_ config: TagConfiguration?) {
        if let _config = config {
            textColor = _config.textColor
            font = _config.font
            textAlignment = .center
            numberOfLines = 0
        }
    }
}



