//
//  EssenceViewController.swift
//  BSBDJ
//
//  Created by apple on 2017/11/6.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit



class EssenceViewController: UIViewController {


    /// 标题内容
    var titles = ["全部内容","视频","声音","图片","段子"]

    /// 滑动的View
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    //底部大的容器存放子视图
    lazy var contentView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.contentSize = CGSize(width: self.view.zc_width * CGFloat(self.titles.count), height: 0)

        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()

    //存储点击的按钮
    var currentButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()


        if #available(iOS 11.0, *) {
            contentView.contentInsetAdjustmentBehavior = .never
        }else{

            automaticallyAdjustsScrollViewInsets = false
        }

        setupUI()
        setupChildViewControllers()

        scrollViewDidEndDecelerating(contentView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
// MARK: - 设置UI
extension EssenceViewController {

    fileprivate func setupUI()  {
        view.addSubview(contentView)
        setupNavigationBar()
        setupTitleView()
    }

    /// 设置导航栏
    private func setupNavigationBar() {
        // 设置导航栏标题
        navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
        // 设置导航栏左边的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: "MainTagSubIcon", highImage: "MainTagSubIconClick", target: self, action: #selector(tagClick))

    }

    /// 设置TitleView
    private func setupTitleView() {

        let titleView = UIView(frame: CGRect(x: 0, y: kTopHeight, width: view.zc_width, height: 35))
        titleView.backgroundColor = UIColor.init(white: 1.0, alpha: 0.7)
        view.addSubview(titleView)

        for i in 0..<titles.count {
            let button = UIButton(type: .custom)
            button.tag = 100 + i
            button.setTitle(titles[i], for: .normal)
            button.setTitleColor(UIColor.darkGray, for: .normal)
            button.setTitleColor(UIColor.red, for: .disabled)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.addTarget(self, action: #selector(clickTitleView(_:)), for: .touchUpInside)
            let width = titleView.zc_width / CGFloat(titles.count)
            let height = titleView.zc_height
            button.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height - 2)

            titleView.addSubview(button)
            if i == 0 {
                button.titleLabel?.sizeToFit()
                self.bottomView.frame = CGRect(x: 0, y: 0, width: button.titleLabel!.zc_width, height: 2)
                self.bottomView.center = CGPoint(x: button.center.x, y:button.zc_height + 1)
                titleView.addSubview(bottomView)
                clickTitleView(button)
            }
        }
    }

}





// MARK: - 添加控制器
extension EssenceViewController {
    func setupChildViewControllers() {
        for i in 0..<5 {
            let vc = EssenceContentViewController()
            switch i {
            case 0:
                vc.type = .all
            case 1:
                vc.type = .video
            case 2:
                vc.type = .voice
            case 3:
                vc.type = .picture
            case 4:
                vc.type = .word
            default:
                vc.type = .all
            }
            addChildViewController(vc)
        }
    }
}

// MARK: - scrollView代理
extension EssenceViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        let index = scrollView.contentOffset.x / scrollView.zc_width
        clickTitleView(view.viewWithTag(100 + Int(index)) as! UIButton)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.zc_width
        let vc = childViewControllers[Int(index)]
        vc.view.frame = CGRect(x: index * contentView.zc_width, y: 0, width: contentView.zc_width, height: contentView.zc_height)
        contentView.addSubview(vc.view)
    }
}

// MARK: - 顶部点击事件
extension EssenceViewController{
    @objc fileprivate func clickTitleView(_ sender: UIButton) {
        currentButton.isEnabled = true
        currentButton = sender
        currentButton.isEnabled = false

        UIView.animate(withDuration: 0.25) {
            self.bottomView.frame = CGRect(x: 0, y: 0, width: self.currentButton.titleLabel!.zc_width, height: 2)
            self.bottomView.center = CGPoint(x: self.currentButton.center.x, y:self.currentButton.zc_height + 1)
        }

        var offSet = contentView.contentOffset
        offSet.x = CGFloat(sender.tag - 100) * contentView.zc_width
        contentView.setContentOffset(offSet, animated: true)
    }
    //导航栏左边的按钮点击事件
    @objc fileprivate func tagClick() {
        let vc = UIViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
