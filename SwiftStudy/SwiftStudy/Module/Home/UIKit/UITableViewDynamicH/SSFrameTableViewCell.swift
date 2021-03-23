//
//  SSFrameTableViewCell.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/12/2.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSFrameTableViewCell: UITableViewCell {

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
        
        contentView.addSubview(nameL)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let str = NSString(string: nameL.text!)
        let rect = str.boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width - 20, height: 300),
                                    options: [.usesFontLeading, .usesLineFragmentOrigin],
                                    attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)],
                                    context: nil)
        let w = rect.size.height
        nameL.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 20, height: w)
    }
    
    
    func setModel(model: SSTableViewModel)  {
        self.nameL.text = model.name
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let str = NSString(string: nameL.text!)
        let rect = str.boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width - 20, height: 300),
                                    options: [.usesFontLeading, .usesLineFragmentOrigin],
                                    attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)],
                                    context: nil)
        return CGSize(width: UIScreen.main.bounds.size.width - 20, height: rect.height)
    }
}
