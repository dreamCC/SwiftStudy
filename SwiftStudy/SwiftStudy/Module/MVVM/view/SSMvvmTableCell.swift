//
//  SSMvvmTableCell.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/17.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSMvvmTableCell: UITableViewCell {
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.textColor = UIColor.lightGray
        contentView.addSubview(lab)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
