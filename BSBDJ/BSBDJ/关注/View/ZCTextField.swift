//
//  ZCTextField.swift
//  BSBDJ
//
//  Created by apple on 2017/11/7.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class ZCTextField: UITextField {
    fileprivate let kPlaceholerLabelKey = "_placeholderLabel.textColor"

fileprivate let leftMargin = 5

    override func awakeFromNib() {
        super.awakeFromNib()
        tintColor = .white
    }

    override func becomeFirstResponder() -> Bool {

        self.setValue(textColor, forKeyPath: kPlaceholerLabelKey)
        return super.becomeFirstResponder()
    }
    override func resignFirstResponder() -> Bool {
        self.setValue(UIColor.gray, forKeyPath: kPlaceholerLabelKey)
        return super.resignFirstResponder()
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.size.width - 10, height: bounds.size.height)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.size.width - 10, height: bounds.size.height)
    }





}
