//
//  SSQMUIView.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/2.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 关于sizeToFit和sizeThatSize的关系。

 
 */
class SSQMUIView: UIView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        //print("SSQMUIView--hitTest", view)
        

        return view
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return super.point(inside: point, with: event)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("SSQMUIView--touchBegin")
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("SSQMUIView--touchesCancelled")

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("SSQMUIView--touchesEnded")

    }
}

class SSQMUI2View: UIView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        //print("SSQMUI2View--hitTest", view)

        return view
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return super.point(inside: point, with: event)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("SSQMUI2View--touchBegin")

        //self.next?.touchesBegan(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("SSQMUI2View--touchesCancelled")

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("SSQMUI2View--touchesEnded")

    }

}

class SSQMUI3View: UIView {
    
    
    override func willMove(toSuperview newSuperview: UIView?) {
        //print("willMove toSuperview", newSuperview)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        let view = super.hitTest(point, with: event)
//        print("SSQMUI3View--hitTest", view)
//        return self
//        return self.subviews.first

        return view
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return super.point(inside: point, with: event)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("SSQMUI3View--touchBegin")
        //super.touchesBegan(touches, with: event)
        next?.touchesBegan(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("SSQMUI3View--touchesCancelled")

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("SSQMUI3View--touchesEnded")

    }


    //------------------------------------------------------------------
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: 200, height: 200)
        }
    }
}
