//
//  MvpViewModel.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/12/31.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import Foundation

protocol MvpPresenterDelegate: class {
    
    func startLoading()
    func stopLoading()
    func getValueComplement(model: MvpModel)
}

class MvpPresenter {
    
    weak var delegate: MvpPresenterDelegate?
    private var model: MvpModel!
    
    func getValue() {
        
        delegate?.startLoading()
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3) {
            DispatchQueue.main.async {
                self.delegate?.stopLoading()
                self.model = MvpModel(name: "David-\(Date().description)", age: "22-\(Date().description)")
                self.delegate?.getValueComplement(
                    model: self.model
                )
            }
        }
    }
    
    func updateInputValue(value: String) {
        self.model.inputValue = value
        self.delegate?.getValueComplement(
            model: self.model
        )
    }
}
