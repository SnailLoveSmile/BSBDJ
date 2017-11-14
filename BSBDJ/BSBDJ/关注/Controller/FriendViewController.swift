//
//  FriendViewController.swift
//  BSBDJ
//
//  Created by apple on 2017/11/7.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavi()
    }


    @IBAction func loginBtnClicked(_ sender: UIButton) {
        let vc = LoginRegisterViewController()
       present(vc, animated: true, completion: nil)
    }



}


// MARK: - 设置导航栏
extension FriendViewController{
    fileprivate func setupNavi() {
        navigationItem.title = "关注"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: "friendsRecommentIcon", highImage: "friendsRecommentIcon-click", target: self, action: #selector(tagClick))
    }
}


// MARK: - 点击事件
extension FriendViewController {

    @objc fileprivate func tagClick(){
        let vc = RecommendViewController()
        navigationController?.pushViewController(vc, animated: true)
    }



}
