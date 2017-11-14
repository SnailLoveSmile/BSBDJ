//
//  MeViewController.swift
//  BSBDJ
//
//  Created by apple on 2017/11/6.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

let kMeCellID = "meCellId"

class MeViewController: UIViewController {



    lazy var tableView: UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.bounds)!, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kMeCellID)

        //iOS11默认开启Self-Sizing，关闭Self-Sizing,才可以触发heightForHeaderInSection代理方法(以下三行代码)
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.delegate = self
        tableView.dataSource = self
        let footView = MeFooterView()
        footView.finishedBlock = {
            tableView.reloadData()
        }
         tableView.tableFooterView = footView
        return tableView
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}


// MARK: - 设置UI
extension MeViewController {
    fileprivate func setupUI() {
        view.addSubview(tableView)
        navigationItem.title = "我"
        setupNavi()
    }

    private func setupNavi() {
       navigationItem.leftBarButtonItem = UIBarButtonItem(image: "mine-setting-icon", highImage: "mine-setting-icon-click", target: self, action: #selector(leftItemClicked))
    }

}



// MARK: - 数据源
extension MeViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
     func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: "meCell")

        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "meCell")
        }

        if indexPath.section == 0 {
            cell?.textLabel?.text = "登录注册"
        } else {
            cell?.textLabel?.text = "离线下载"
        }
        return cell!

    }
}


// MARK: - tableView代理方法
extension MeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kCellTextMargin
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}














//点击事件
extension MeViewController {
   @objc fileprivate func leftItemClicked() {
    print("点击了顶部左侧按钮")
    }

}





