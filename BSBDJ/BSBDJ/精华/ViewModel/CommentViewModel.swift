//
//  CommentViewModel.swift
//  BSBDJ
//
//  Created by apple on 2017/11/13.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit
import Alamofire
class CommentViewModel: NSObject {
    var canLoadMore = true
    var hotComments = [CommentModel]()
    var newComments = [CommentModel]()
    var page: Int = 0

    func loadData(contentID: String, boolFirstLoad: Bool, finishedBlock:@escaping ()->()){

        if !canLoadMore {
             finishedBlock()
            return
        }

        let url = URL(string: "http://api.budejie.com/api/api_open.php")


        var parameter = [String: String]()

        parameter["a"] = "dataList"
        parameter["c"] = "comment"
        parameter["data_id"] = contentID

        if boolFirstLoad {
            parameter["hot"] = "1"
        }else{
         page += 1
         parameter["page"] = "\(page)"
         parameter["lastcid"] = newComments.last?.ID ?? ""
        }


        Alamofire.request(url!, method: .get, parameters: parameter).responseJSON{ (response) in

            switch response.result {
            case let .success(value):
                guard let data = value as? [String : Any] else{
                    return
                }

                if let hotData = data["hot"] as? [Any] {
                    for dic in hotData {
                        self.hotComments.append(CommentModel(dict: dic as! [String : Any]))
                    }
                }

                if let newData = data["data"] as? [Any] {
                    for dic in newData {
                        self.newComments.append(CommentModel(dict: dic as! [String : Any]))
                    }
                }
                //这里比较扯淡, 百思不得其解返回的total类型有string, 也有Int类型, 还有就是这里加载更多总是比total的少, 不知道原因在哪里
                var allCount = 0
                if let total = data["total"] as? String {
                    allCount = Int(total) ?? 0
                }
                if let otherTotal = data["total"] as? Int {
                    allCount = otherTotal
                }

                if self.newComments.count >= allCount {
                    self.canLoadMore = false
                }
                print("最新的个数\(self.newComments.count), 最热的个数\(self.hotComments.count), 全部个数:\(allCount)")
                finishedBlock()
            case let .failure(error):
                print(error)
                self.page -= 1
            }
        }

    }
}
