//
//  EssenceNewViewModel.swift
//  BSBDJ
//
//  Created by apple on 2017/11/13.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit
import Alamofire
class EssenceNewViewModel: NSObject {

        fileprivate static var userTempDic = [String: String]()

    class func loadContentsNow(a: String, type:Int, page: Int = 1, maxTime: String = "", finishedBlock:@escaping ((success:Bool, mTime: String, array :[ContentModel]))->()) {

        var parameter = [String: String]()
        parameter["a"] = a
        parameter["c"] = "data"
        parameter["page"] = "\(page)"
        parameter["type"] = "\(type)"
        parameter["maxtime"] = maxTime
        userTempDic = parameter
        let url = URL(string: "http://api.budejie.com/api/api_open.php")
        Alamofire.request(url!, method: .get, parameters: parameter).responseJSON { (response) in

            if userTempDic != parameter {
                return
            }
            switch response.result {


            case let .success(value):
                guard let dict = value as? [String: Any] else {
                    return
                }
                guard let datas = dict["list"] as? [[String: Any]] else {
                    return
                }
                var mmTime = ""
                if let lastTime = dict["info"] as? [String: Any] {
                    mmTime  = (lastTime["maxtime"] as? String) ?? ""
                }
                var data = [ContentModel]()
                for dic in datas {
                   data.append(ContentModel(dict: dic))
                }
                finishedBlock((true, mmTime, data))
            case let .failure(error):
                finishedBlock((false, "", [ContentModel]()))
                print("load content \(error)")
            }
        }
    }



}
