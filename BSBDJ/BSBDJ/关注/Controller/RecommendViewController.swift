//
//  RecommendViewController.swift
//  BSBDJ
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit
import Alamofire

fileprivate let categoryCellID = "categoryCellID"
fileprivate let userCellID = "userCellID"
class RecommendViewController: UIViewController {
    var tempIndexRow = 0
    lazy var recommendVM = RecommendViewVM()
    @IBOutlet weak var categroyTableView: UITableView!
    @IBOutlet weak var userTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendVM.getCategoryData { [weak self] in

            print("日了够了---------------------")
            self?.categroyTableView.reloadData()

            self?.categroyTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
            guard let categoryModel = self?.recommendVM.categoryArray.first  else {return}
            self?.recommendVM.getUserData(catagroy:categoryModel, jsonDataBlock: {
                self?.userTableView.reloadData()
            })
        }
        setupUI()
    }
}

extension RecommendViewController {
    fileprivate func setupUI() {
        navigationItem.title = "推荐关注"
        categroyTableView.scrollsToTop = false
        categroyTableView.register(UINib.init(nibName: "RecommendCategoryCell", bundle: nil), forCellReuseIdentifier: categoryCellID)
        userTableView.register(UINib.init(nibName: "RecommendUserCell", bundle: nil), forCellReuseIdentifier: userCellID)

    }
}



// MARK: - 数据源
extension RecommendViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == categroyTableView {
            return recommendVM.categoryArray.count
        }else {
            guard let row = categroyTableView.indexPathForSelectedRow?.row else {
                return 0
            }
            return recommendVM.categoryArray[row].users.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == categroyTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellID) as! RecommendCategoryCell
            cell.model = recommendVM.categoryArray[indexPath.row]
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: userCellID) as! RecommendUserCell
            let row = categroyTableView.indexPathForSelectedRow?.row
            let category = recommendVM.categoryArray[row!]
            let array = category.users
            if array.count > 0 {
                cell.model = array[indexPath.row]
            }
            //在这里校验 是否还能再继续加载避免再次发起请求
            if indexPath.row == category.users.count - 1 && category.canLoadMore{
              recommendVM.getUserData(catagroy: recommendVM.categoryArray[row!], jsonDataBlock: {
               self.userTableView.reloadData()
            })
            }

            return cell
        }
    }
}

// MARK: - 代理方法
extension RecommendViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == categroyTableView {
            return 40
        }else {
            return 70
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == categroyTableView {
            let row = categroyTableView.indexPathForSelectedRow?.row
            let model = recommendVM.categoryArray[row!]
            recommendVM.getUserData(catagroy: model, jsonDataBlock: {
                self.userTableView.reloadData()
                self.userTableView.scrollToRow(at:  IndexPath(row: 0, section: 0), at: .top, animated: false)
            })
        }else {

        }
    }

}
