//
//  CodeView.swift
//  Cros
//
//  Created by JiWei Xiong on 2019/1/18.
//  Copyright © 2019 Wu Lei. All rights reserved.
//

import UIKit

@objc protocol CodeViewDelegate {

    @objc optional func passwordView(textChanged: String, length: Int)

    func passwordView(textFinished: String)
}

class CodeView: UIView, UIKeyInput {

    private var text: NSMutableString = ""

    var delegate: CodeViewDelegate?

    var maxLength: Int = 6

    var hasText: Bool {
        return text.length > 0
    }

    func insertText(_ text: String) {
        if self.text.length < maxLength {
            self.text.append(text)
            delegate?.passwordView?(textChanged: self.text as String, length: self.text.length)
            setNeedsDisplay()
            if self.text.length == maxLength {
                self.resignFirstResponder()
                delegate?.passwordView(textFinished: self.text as String)
            }
        }
    }

    func deleteBackward() {
        if self.text.length > 0 {
            self.text.deleteCharacters(in: NSRange(location: text.length - 1, length: 1))
            delegate?.passwordView?(textChanged: self.text as String, length: self.text.length)
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let width = rect.width / CGFloat(maxLength)
        context.setStrokeColor(UIColor.qmui_color(withHexString: "0xcccccc")!.cgColor)
        context.setLineWidth(1)
        context.stroke(rect)
        let path = UIBezierPath()
        (1..<maxLength).forEach { (index) in
            path.move(to: CGPoint(x: rect.origin.x + CGFloat(index) * width, y: rect.origin.y))
            path.addLine(to: CGPoint(x: rect.origin.x + CGFloat(index) * width, y: rect.origin.y + rect.height))
        }
        context.addPath(path.cgPath)
        context.strokePath()
        let pointSize = CGSize(width: width * 0.3, height: width * 0.3)
        (0..<self.text.length).forEach { (index) in
            let origin = CGPoint(x: rect.origin.x + CGFloat(index) * width + (width - pointSize.width) / 2, y: rect.origin.y + (rect.height - pointSize.height) / 2)
            let pointRect = CGRect(origin: origin, size: pointSize)
            context.fillEllipse(in: pointRect)
        }
    }

    var keyboardType: UIKeyboardType {
        get {
            return .numberPad
        } set {

        }
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isFirstResponder {
            becomeFirstResponder()
        }
    }

}
