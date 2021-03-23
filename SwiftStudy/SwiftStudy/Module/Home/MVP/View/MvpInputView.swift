//
//  MvpInputView.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/4.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit

protocol MvpInputViewDelegate: class {
    
    func inputValueChange(value: String)
}

class MvpInputView: UIView, QMUITextFieldDelegate {

    weak var delegate: MvpInputViewDelegate?
    
    lazy var inputField: QMUITextField = {
        let field = QMUITextField()
        field.maximumTextLength = 6
        field.font = UIFont.systemFont(ofSize: 14)
        field.textColor = UIColor.red
        field.borderStyle = .roundedRect
        field.layer.borderColor = UIColor.purple.cgColor
        field.layer.borderWidth = 2
        field.delegate = self
        return field
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray
        
        addSubview(inputField)
        inputField.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(44)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.inputValueChange(value: textField.text ?? "")
        return true
    }
}
