//
//  LoginRegisterViewController.swift
//  BSBDJ
//
//  Created by apple on 2017/11/7.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class LoginRegisterViewController: UIViewController {

    @IBOutlet weak var loginLeftConstant: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    @IBAction func dismissNow(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func registerOrLogin(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        loginLeftConstant.constant = sender.isSelected ? -view.zc_width : 0

        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func bottomBtnClicked(_ sender: UIButton) {
        switch sender.tag {
        case 1000:
            print("QQ按钮")
        case 1001:
            print("微博按钮")
        case 1002:
            print("腾讯微博按钮")
        default:
            print("no way")
        }



    }

}
