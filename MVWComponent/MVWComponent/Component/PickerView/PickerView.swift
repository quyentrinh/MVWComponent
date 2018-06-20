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

protocol PickerViewDelegate: class {
    func pickerView(_ picker: PickerView, didSelected value: String?, at index: Int)
}

class PickerView: UIView {
    
    weak var delegate : PickerViewDelegate?
    
    
    //constant value

    private let buttonColor: UIColor = UIColor(red: 74/255.0, green: 105/255.0, blue: 158/255.0, alpha: 1.0)
    private let buttonTitleFont: UIFont = UIFont.systemFont(ofSize: 13, weight: .regular)
    private let toolBarHeight: CGFloat = 44.0
    private let headerBarHeight: CGFloat = 100.0
    lazy var pickerHeight: CGFloat = {
        let defaultH = bounds.size.width*(224/375) + toolBarHeight
        if pickerType == .booking {
            return defaultH + headerBarHeight //header
        }
        return defaultH
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
    
    //property
    private var selectedIndex: Int!

    //outlet
    private var contentView: UIView!
    private var toolBar: UIToolbar!
    private var headerView: UIView!
    private var constraintBottomLayout: NSLayoutConstraint!
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button = createBarButton()
        button.setTitle("キャンセル", for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        let item = UIBarButtonItem(customView: button)
        return item
    }()
    private lazy var doneButton: UIBarButtonItem = {
        let button = createBarButton()
        button.setTitle("完了", for: .normal)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        let item = UIBarButtonItem(customView: button)
        return item
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
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: self, action: nil)
        space.width = 24.0
        
        toolbar.items = [space, cancelButton, flexibleSpace, doneButton, space]
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
    
    private func createBarButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = buttonTitleFont
        button.setTitleColor(buttonColor, for: .normal)
        return button
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
        let picker = UIDatePicker(frame: .zero)
        picker.datePickerMode = .date
        picker.maximumDate = Date()
        picker.backgroundColor = .white
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(picker)
        
        picker.topAnchor.constraint(equalTo: toolBar.bottomAnchor).isActive = true
        picker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    private func createBookingPicker() {
        createNormalPicker()
        
        guard let header = Bundle.main.loadNibNamed("BookingHeaderView", owner: nil, options: nil)?.first as? BookingHeaderView else { return }
        header.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(header)
        headerView = header
    }
    
    private func updateLayout() {
        
        let frame = appWindow.bounds
        self.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        toolBar.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        toolBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        toolBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        toolBar.heightAnchor.constraint(equalToConstant: toolBarHeight).isActive = true
        
        if let header = headerView {
            header.topAnchor.constraint(equalTo: toolBar.bottomAnchor).isActive = true
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            header.heightAnchor.constraint(equalToConstant: headerBarHeight).isActive = true
        }
        
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: pickerHeight).isActive = true
        
        let bot = contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: pickerHeight)
        addConstraint(bot)
        constraintBottomLayout = bot
        
        layoutIfNeeded()
    
    }
    
    
    
    
    
    
 
    
    
}

private extension PickerView {
    
    @objc func cancelButtonTapped() {
        dismiss()
    }
    
    @objc func doneButtonTapped() {
        dismiss()
        switch pickerType {
        case .datetime:
            return
        default:
            if let action = delegate?.pickerView(self, didSelected: data[selectedIndex], at: selectedIndex) {
                action
            }
        }
        
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
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











