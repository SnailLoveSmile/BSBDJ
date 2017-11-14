//
//  MeFootModel.swift
//  BSBDJ
//
//  Created by apple on 2017/11/7.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class MeFootModel: NSObject {
    var icon = ""
    var name = ""
    var url = ""
    init(_ dic: [String: Any]) {
        guard let name = dic["name"] as? String, let icon = dic["icon"] as? String, let url = dic["url"] as? String else {
            return
        }
        self.name = name
        self.icon = icon
        self.url = url
    }
}
