//
//  SSPageCollectionViewCell.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/11/2.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSPageCollectionViewCell: UICollectionViewCell {
    
    var lab: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        return lab;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.red
        
        contentView.addSubview(lab)
        lab.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
