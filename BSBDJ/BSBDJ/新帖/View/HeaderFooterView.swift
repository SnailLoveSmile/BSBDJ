//
//  HeaderFooterView.swift
//  BSBDJ
//
//  Created by apple on 2017/11/13.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class HeaderFooterView: UITableViewHeaderFooterView {

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 5, y: 0, width: 300, height: 30))
        label.textColor = UIColor.lightGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()



    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    /// 设置页面
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = UIColor(222, 222, 222, 1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
