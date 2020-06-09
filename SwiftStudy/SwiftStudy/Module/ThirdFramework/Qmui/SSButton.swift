//
//  SSButton.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/5.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSButton: UIButton {
    
    
    
    
    // 当使用autoLayout的时候，会调用该属性。
   override var intrinsicContentSize: CGSize {
       get {
           print("intrinsicContentSize---")
           return super.intrinsicContentSize
       }
   }
   
   
   // 和intrinsicContentSize一样，当我们通过AntoLayout调用的时候，会调用。
   override func updateConstraints() {
       super.updateConstraints()
       
       print("updateConstraints---")
   }

    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews---")

    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print("draw: rect---")

    }

   
    
    // 返回合适的尺寸，当我们调用sizeToFit的时候，会调用该方法。所以我们一般重写该方法，并不会重写sizeToFit
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        print("sizeThatFits", size)
        
        return super.sizeThatFits(size)
    }
    
    
    // 遍历子layer。
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
    }

}
