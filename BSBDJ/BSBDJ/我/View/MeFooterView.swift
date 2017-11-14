//
//  MeFooterView.swift
//  BSBDJ
//
//  Created by apple on 2017/11/7.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit
import Alamofire

class MeFooterView: UIView {

    var finishedBlock: (()->())?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        loadData()
    }
}


// MARK: - 网络请求
extension MeFooterView {
    fileprivate func loadData() {
        MeFootViewVM.loadMeVCData { [weak self] (meFootViewModelArray) in
            self?.setupButtons(meFootViewModelArray)
        }
    }
}






// MARK: - 获取数据后创建按钮
extension MeFooterView {
   fileprivate func setupButtons(_ data: [MeFootModel]) {
        let maxCols: CGFloat = 4
        let buttonW = kScreenWidth / maxCols
        let buttonH = buttonW

        for i in 0..<data.count {

            let button = VeticalSqureBtn()
            button.content = data[i]
            // 行
            let row = i / Int(maxCols)
            // 列
            let col = CGFloat(i).truncatingRemainder(dividingBy: maxCols)
            let x = col * buttonW
            let y = CGFloat(row) * buttonH
            button.frame = CGRect(x: x, y: y, width: buttonW, height: buttonH)
            addSubview(button)
        }

        // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
        let rows = (CGFloat(data.count) + maxCols - 1) / maxCols
        frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: rows * buttonH)

        finishedBlock?()
    }
}





