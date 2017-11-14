//
//  EssenceContentViewController.swift
//  BSBDJ
//
//  Created by apple on 2017/11/10.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit
import Alamofire


fileprivate let indentifier = "cell"

class EssenceContentViewController: UITableViewController {

    var a: String {
        return parent.self!.isKind(of: NewViewController.self) ? "newlist":"list"
    }
        var contents = [ContentModel]()
        var page: Int = 0
        var maxTime: String = ""
        var type: ContentType = .all
        var currentIndex = 0
        override func viewDidLoad() {
            super.viewDidLoad()
            setupTabUI()
            loadContents()
        }
}

// MARK: - 设置UI界面
extension EssenceContentViewController{
    fileprivate func setupTabUI(){
        tableView.register(UINib.init(nibName: "ContentCell", bundle: nil), forCellReuseIdentifier: indentifier)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.contentInset = UIEdgeInsets(top: kTopHeight + 24, left: 0, bottom: kTabBarHeight, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.separatorStyle = .none
    }
}







// MARK: - 请求数据
extension EssenceContentViewController {

    fileprivate func loadContents() {
        page += 1
        EssenceNewViewModel.loadContentsNow(a: a, type: type.rawValue, page: page, maxTime: maxTime) { (isSuccess, maxTime, dataArray) in
            if isSuccess{
                self.maxTime = maxTime
                self.contents += dataArray
                self.tableView.reloadData()
            }else{
                self.page -= 1
            }
        }
    }
}
// MARK: - dataSource
extension EssenceContentViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indentifier) as! ContentCell
        cell.content = contents[indexPath.row]

        if indexPath.row == contents.count - 1 {
            self.loadContents()
        }
        return cell
    }
}
// MARK: - delegate
extension EssenceContentViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommentViewController()
        vc.content = contents[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return contents[indexPath.row].cellHeight

    }
}


