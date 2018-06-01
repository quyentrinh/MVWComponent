//
//  SegmentBarView.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 5/31/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

protocol SegmentBarViewDatasource: class {
    func numberOfItems(in segmentbar: SegmentBarView) -> Int?
    func segmentBarView(_ segmentbar: SegmentBarView, titleForRowAt Index: Int) -> String?
    func segmentBarView(_ segmentbar: SegmentBarView, sizeForRowAt Index: Int) -> CGSize?
}

protocol SegmentBarViewDelegate: class {
    func segmentBarView(_ segmentbar: SegmentBarView, didSelectItemAt Index: Int)
    func segmentBarView(_ segmentbar: SegmentBarView, didDeselectItemAt Index: Int)
}

class SegmentBarView: UIView {

    weak var datasource : SegmentBarViewDatasource?
    weak var delegate : SegmentBarViewDelegate?
    
    private var collectionView : UICollectionView!
    private static let reuseIdentify = "segmentbarcell"
    
    private var shouldSetupConstraints = true
    
    private var selectedRow  = [IndexPath]()
    
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
        _collectionView.register(SegmentBarCell.self, forCellWithReuseIdentifier: SegmentBarView.reuseIdentify)
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
        if let number = datasource?.numberOfItems(in: self) {
            return number
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentBarView.reuseIdentify, for: indexPath) as! SegmentBarCell
        cell.updateBorderColor(selected: selectedRow.contains(indexPath))
        if let title = datasource?.segmentBarView(self, titleForRowAt: indexPath.row) {
            cell.titleLabel.text = title
        }
        return cell
    }
    
    //MARK: - Delgate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SegmentBarCell
        if selectedRow.contains(indexPath) {
            deSelected(cell: cell, indexPath: indexPath)
            if let action = delegate?.segmentBarView(self, didDeselectItemAt: indexPath.row) {
                action
            }
        } else {
            selected(cell: cell, indexPath: indexPath)
            if let action = delegate?.segmentBarView(self, didSelectItemAt: indexPath.row) {
                action
            }
        }
    }
    
    //MARK: - FlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let size = datasource?.segmentBarView(self, sizeForRowAt: indexPath.row) {
            return size
        }
        return CGSize(width: 50, height: 30)
    }
    
}

extension SegmentBarView {
    
    func selected(cell : SegmentBarCell, indexPath : IndexPath) {
        selectedRow.append(indexPath)
        cell.updateBorderColor(selected: true)
    }
    
    func deSelected(cell : SegmentBarCell, indexPath : IndexPath) {
        if let index = selectedRow.index(of: indexPath) {
            selectedRow.remove(at: index)
        }
        cell.updateBorderColor(selected: false)
    }
    
}


class SegmentBarCell: UICollectionViewCell {
    
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
        content.addBorder()
        contentView.addSubview(content)
        
        titleLabel = UILabel()
        titleLabel.frame = content.bounds
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.lightGray
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        content.addSubview(titleLabel)
        
    }
    
    func updateBorderColor(selected: Bool) {
        if selected {
            content.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            titleLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        } else {
            content.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            titleLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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


