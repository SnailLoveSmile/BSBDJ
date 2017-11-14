//
//  ProgressView.swift
//  BSBDJ
//
//  Created by apple on 2017/11/10.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit
import KYCircularProgress
class ProgressView: KYCircularProgress {

    let textLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupView()
    }

    func setupView() {

        colors = [UIColor.lightGray]
        guideColor = UIColor.white

        self.addSubview(textLabel)
    }
    public func setProgress(_ progress: Double, duration: Double) {
        self.set(progress: progress, duration: duration)
        textLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        textLabel.backgroundColor = UIColor.clear
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.gray
        let p = Int(progress * 100) % 100
        textLabel.text = "\(p)" + "%"
    }
    override func layoutSubviews() {

        super.layoutSubviews()

    }


}
