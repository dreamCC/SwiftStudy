//
//  UIView+extention.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/11/19.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import Foundation

protocol EmptyViewAble {
    
    var emptyView: QMUIEmptyView { get }
    func showEmptyView()
}

private var emptyViewKey: Void?
extension EmptyViewAble {
    
    var emptyView: QMUIEmptyView {
        get {
            
            var view = objc_getAssociatedObject(self, &emptyViewKey) as? QMUIEmptyView
            if view == nil {
                view = QMUIEmptyView()
                view?.backgroundColor = UIColor.purple
                view?.textLabel.text = "EmptyViewAble"

                objc_setAssociatedObject(self, &emptyViewKey, view, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return view!
        }
    }
    

}


extension EmptyViewAble where Self: UIViewController {

    func showEmptyView() {
        
        if emptyView.isDescendant(of: view) {
            return
        }
        print("addSubview--")
        emptyView.frame = view.bounds
        view.addSubview(emptyView)
    }
}

extension EmptyViewAble where Self: UIView {
    

    func showEmptyView() {
        
        if emptyView.isDescendant(of: self) {
            return
        }
        print("addSubview--")
        emptyView.frame = bounds
        addSubview(emptyView)
    }
}

