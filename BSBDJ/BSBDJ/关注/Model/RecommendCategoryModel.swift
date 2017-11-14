//
//  RecommendCategoryModel.swift
//  BSBDJ
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class RecommendCategoryModel: NSObject {
    var count : Int = 0
    var ID: Int = 0
    var name = ""
    var users: [RecommendUserModel] = [RecommendUserModel]()
    var currentPage = 0
    var total_Count = 0
    var canLoadMore:Bool = true
    init(dict: [String: Any]) {
        guard let count = dict["count"] as? Int, let ID = dict["id"] as? Int, let name = dict["name"] as? String else {
            return
        }
        self.name = name
        self.ID = ID
        self.count = count
    }

}
