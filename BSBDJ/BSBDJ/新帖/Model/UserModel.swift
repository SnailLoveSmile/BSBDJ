//
//  UserModel.swift
//  BSBDJ
//
//  Created by apple on 2017/11/10.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    var username: String = ""
    var sex: String = ""
    var profile_image: String = ""

    init(dict: [String: Any]) {
        username = dict["username"] as? String ?? ""
        sex = dict["sex"] as? String ?? ""
        profile_image = dict["profile_image"] as? String ?? ""
    }
}
