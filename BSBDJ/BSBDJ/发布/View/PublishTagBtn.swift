//
//  PublishTagBtn.swift
//  BSBDJ
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class PublishTagBtn: UIButton {
    
    class func publishTagButton(_ isAdd: Bool) -> PublishTagBtn {
        return PublishTagBtn.init(isAdd)
    }


    convenience init(_ isAdd: Bool) {
        self.init(type: .custom)
        setupView(isAdd)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = zc_height / 2.0
        layer.masksToBounds = true
    }

    private func setupView(_ isAdd: Bool) {
        if isAdd {
            setImage(UIImage.init(named: "chose_tag_close_icon"), for: .normal)
        }
        backgroundColor = UIColor(166, 220, 72, 1.0)
        titleLabel?.textColor = UIColor.white
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}





