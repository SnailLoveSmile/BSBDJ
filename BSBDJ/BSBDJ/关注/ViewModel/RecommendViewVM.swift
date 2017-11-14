//
//  RecommendViewVM.swift
//  BSBDJ
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit
import Alamofire
class RecommendViewVM {



    lazy var categoryArray = [RecommendCategoryModel]()
    fileprivate var userTempDic = [String: String]()
    func getCategoryData(jsonBlock: @escaping ()->()) {
        let parameters = ["a":"category", "c": "subscribe"]
        let urlString = "http://api.budejie.com/api/api_open.php"
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON { (respond) in
            switch respond.result {
            case.success(let value):
                guard let r_dicts = value as? [String : Any] else{return}
                let dicts = r_dicts["list"] as? [[String : Any]]
                guard let lists = dicts else {
                    return
                }
                for dict in lists {
                    let categroy = RecommendCategoryModel(dict: dict)
                    self.categoryArray.append(categroy)
                }
                jsonBlock()
            case.failure:
                print("fail")
            }
        }
    }


    func getUserData(catagroy: RecommendCategoryModel, jsonDataBlock:@escaping ()->()) {

        if !catagroy.canLoadMore {
            jsonDataBlock()
            return
        }
        let urlString = "http://api.budejie.com/api/api_open.php"
        catagroy.currentPage += 1
        let parameters = ["a":"list", "c": "subscribe", "category_id": "\(catagroy.ID)", "page":"\(catagroy.currentPage)"]

        userTempDic = parameters

        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON { (respond) in
            if self.userTempDic != parameters {
                return
            }
            switch respond.result{
            case .success(let value):
                guard let r_dicts = value as? [String : Any] else {
                    return
                }
                catagroy.total_Count = (r_dicts["total"] as? Int) ?? 0
                let dicts = r_dicts["list"] as? [[String : Any]]
                guard let lists = dicts else {
                    return
                }
                for dict in lists {
                    let user = RecommendUserModel(dict: dict)
                    catagroy.users.append(user)
                }
                print("catagroy.users.count=\(catagroy.users.count)  catagroy.total_Count=\(catagroy.total_Count)")
                if catagroy.users.count >= catagroy.total_Count {
                    catagroy.canLoadMore = false
                }

                jsonDataBlock()
            case.failure:
                catagroy.currentPage -= 1
            }


        }


    }
}
