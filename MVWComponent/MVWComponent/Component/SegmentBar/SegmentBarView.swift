//
//  SegmentBarView.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 5/31/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class SegmentBarView: UIView {

    var collectionView : UICollectionView!
    
    var shouldSetupConstraints = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let _collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        _collectionView.delegate = self
        _collectionView.backgroundColor = .white
        _collectionView.dataSource = self
        _collectionView.showsHorizontalScrollIndicator = false
        _collectionView.showsVerticalScrollIndicator = false
        _collectionView.register(SegmentBarCell.self, forCellWithReuseIdentifier: "segmentbarcell")
        addSubview(_collectionView)
        collectionView = _collectionView
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if shouldSetupConstraints {
            collectionView.frame = self.bounds
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
}

extension SegmentBarView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "segmentbarcell", for: indexPath) as! SegmentBarCell
        return cell
    }
    
    //MARK: - Delgate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SegmentBarCell
        cell.updateBorderColor()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SegmentBarCell else { return }
        cell.updateBorderColor()
    }
    
    
    //MARK: - FlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 40)
    }
    
}


class SegmentBarCell: UICollectionViewCell {
    
    var content : UIView!
    var title : UILabel!
    
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
        content.addBorder()
        contentView.addSubview(content)
    }
    
    func updateBorderColor() {
        if self.isSelected {
            content.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        } else {
            content.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
}

private extension UIView {
    
    func addBorder() {
        layer.cornerRadius = 5.0
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.borderWidth = 1.0
    }
    
}


