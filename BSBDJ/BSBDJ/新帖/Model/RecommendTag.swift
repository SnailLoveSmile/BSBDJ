//
//  RecommendTag.swift
//  BSBDJ
//
//  Created by apple on 2017/11/13.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class RecommendTag: NSObject {
    var image_list: String = ""
    var theme_name: String = ""
    var sub_number: Int = 0
    init(dict: [String: Any]) {
        super.init()
        image_list = dict["image_list"] as? String ?? ""
        theme_name = dict["theme_name"] as? String ?? ""
       sub_number = Int((dict["sub_number"] as? NSString ?? "0").intValue)

    }
}
