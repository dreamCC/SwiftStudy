//
//  SSTableViewCell.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/28.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSAutoLayoutTableViewCell: UITableViewCell {
    
    
    private let nameL: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.qmui_random()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.backgroundColor = UIColor.gray
        lab.numberOfLines = 0
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("-init--reuseIdentifier")

        contentView.addSubview(nameL)
        nameL.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        self.nameL.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 20
        return self.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    

    
    func setModel(model: SSTableViewModel)  {
        self.nameL.text = model.name
        
        if model.isOpen {
            openH()
        }else {
            closeH()
        }
    }
    
    private func closeH() {
        nameL.snp.remakeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(40)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
        }
    }
    
    private func openH() {
        nameL.snp.remakeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)        
    }
}
