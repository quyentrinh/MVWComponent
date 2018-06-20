//
//  PickerView.swift
//  MVWComponent
//
//  Created by Quyen Trinh on 6/20/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

enum PickerType {
    case normal
    case datetime
    case booking
}

class PickerView: UIView {
    
    //constant value

    private let toolBarHeight: CGFloat = 44.0

    lazy var pickerHeight: CGFloat = {
        return bounds.size.width*(224/375) + toolBarHeight
    }()

    private var appWindow: UIWindow {
        guard let window = UIApplication.shared.keyWindow else {
            debugPrint("KeyWindow not set. Returning a default window for unit testing.")
            return UIWindow()
        }
        return window
    }
    
    //data
    private var pickerType: PickerType = .normal
    private var data: [String]! = {
       return ["1", "2", "3", "4", "5"]
    }()
    

    //outlet
    private var contentView: UIView!
    private var toolBar: UIToolbar!
    private var constraintBottomLayout: NSLayoutConstraint!
    
    private var flexibleSpace: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
    }()
    private var cancelButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
    }()
    private var doneButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
    }()
    
    init(data: [String], type: PickerType) {
        super.init(frame: .zero)
        pickerType = type
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    
    private func setupUI() {
        
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        addSubview(view)
        contentView = view
        
        let toolbar = UIToolbar(frame: .zero)
        toolbar.tintColor = .darkGray
        toolbar.barTintColor = .white
        toolbar.items = [cancelButton, flexibleSpace, doneButton]
        view.addSubview(toolbar)
        toolBar = toolbar
        
        switch pickerType {
        case .normal:
            createNormalPicker()
        case .datetime:
            createDateTimePicker()
        case .booking:
            createBookingPicker()
        }
        updateLayout()
    }
    
    private func createNormalPicker() {
        let picker = UIPickerView(frame: .zero)
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .white
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(picker)
        
        picker.topAnchor.constraint(equalTo: toolBar.bottomAnchor).isActive = true
        picker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    private func createDateTimePicker() {
        
    }
    
    private func createBookingPicker() {
        createNormalPicker()
    }
    
    private func updateLayout() {
        
        let frame = appWindow.bounds
        self.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: pickerHeight).isActive = true
        
        let bot = contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: pickerHeight)
        addConstraint(bot)
        constraintBottomLayout = bot
        
        toolBar.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        toolBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        toolBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        toolBar.heightAnchor.constraint(equalToConstant: toolBarHeight).isActive = true
        
        layoutIfNeeded()
    
    }
    
    
    
    
    
    
 
    
    
}

private extension PickerView {
    
    @objc func cancelButtonTapped() {
        dismiss()
    }
    
}


extension PickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
}


extension PickerView {
    func show() {
        appWindow.addSubview(self)
        constraintBottomLayout.constant = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.layoutIfNeeded()
        }, completion: { _ in

        })
    }
    
    func dismiss() {
        constraintBottomLayout.constant = pickerHeight
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            self.layoutIfNeeded()
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
}











