//
//  Common.swift
//  BSBDJ
//
//  Created by apple on 2017/11/6.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

let kCellTextMargin: CGFloat = 10
let kCellHeaderHeight: CGFloat = 65
let kCellFooterHeight: CGFloat = 54
let kCellIamgeMaxH: CGFloat = 1500
let kCellImageBreakHeight: CGFloat = 250
let kStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
let iPhoneXHeight: CGFloat = 812
let kNavBarHeight:CGFloat = 44.0

/*代替之前的49*/
let kTabBarHeight: CGFloat = (UIApplication.shared.statusBarFrame.size.height > 20.0 ? 83.0:49.0)

/*代替之前的64*/
let kTopHeight = kStatusBarHeight + kNavBarHeight

let kScreenWidth = UIScreen.main.bounds.width

let kScreenHeight = UIScreen.main.bounds.height

 enum ContentType: Int {
    case all = 1
    case picture = 10
    case word = 29
    case voice = 31
    case video = 41
}

