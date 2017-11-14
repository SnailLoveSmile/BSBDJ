//
//  PublishTextViewController.swift
//  BSBDJ
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit
import GrowingTextView
class PublishTextViewController: UIViewController {

    private lazy var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setBackgroundImage(UIImage(named:"my_addBtn"), for: .normal)
        button.addTarget(self, action: #selector(addtag), for: .touchUpInside)
        return button
    }()

    @IBOutlet weak var tagViewH: NSLayoutConstraint!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var textView: GrowingTextView!
    @IBOutlet weak var bottomView: UIView!
    var tagButtons: [PublishTagBtn] = [PublishTagBtn]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension PublishTextViewController {
    fileprivate func setupNavigationItem() {

        navigationItem.title = "发表文字"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", fontSize:15, self, #selector(backToPreVC))
        setupUI()
    }

    private func setupUI() {

        // 1.创建标签button
        let btn1 = PublishTagBtn.init(false)
        btn1.setTitle("搞笑", for: .normal)
        let btn2 = PublishTagBtn.init(false)
        btn2.setTitle("糗事", for: .normal)
        // 2.计算button的位置
        tagButtons.append(btn1)
        tagButtons.append(btn2)
        setTagButtonsFrame(tagButtons)

    }
}





// MARK: - tag标签布局
extension PublishTextViewController {
    fileprivate func setTagButtonsFrame(_ buttons: [PublishTagBtn]){

        let maxWidth = (kScreenWidth - kCellTextMargin * 2)

        var maxHeight: CGFloat = 40.0

        let buttonHeight: CGFloat = 40.0

        let y: CGFloat = 5
        for i in 0..<buttons.count  {

            let button = buttons[i]
            var width = button.titleLabel!.text!.width(CGSize.init(width: 1000.0, height: 40.0), [NSAttributedStringKey.font: button.titleLabel?.font ?? UIFont.systemFont(ofSize: 15.0)])

            width += kCellTextMargin

            if width > maxWidth {
                width = maxWidth
            }

            if i == 0 {
                button.frame = CGRect(x: kCellTextMargin, y: y, width: width, height: buttonHeight - kCellTextMargin)
            } else {
                let previousButton = buttons[i - 1]
                let previousButtonMaxX = previousButton.frame.maxX
                if  previousButtonMaxX + width > maxWidth{
                    button.frame = CGRect(x: kCellTextMargin, y: maxHeight + y, width: width, height: buttonHeight - kCellTextMargin)
                    maxHeight += buttonHeight
                } else {
                    button.frame = CGRect(x: previousButtonMaxX + 10, y: maxHeight - buttonHeight + y, width: width, height: buttonHeight - kCellTextMargin)
                }
            }

            if i == buttons.count - 1 {
                let previousButton = buttons[i]
                let previousButtonMaxX = previousButton.frame.maxX
                if  previousButtonMaxX + addButton.frame.width > maxWidth{
                    addButton.frame = CGRect(x: kCellTextMargin, y: maxHeight + y, width: 30, height: 30)
                    maxHeight += buttonHeight
                } else {
                    addButton.frame = CGRect(x: previousButtonMaxX + 10, y: maxHeight - buttonHeight + y, width: 30, height: 30)
                }
                tagView.addSubview(addButton)
            }
            tagView.addSubview(button)
        }
        tagViewH.constant = maxHeight + 5
        view.layoutIfNeeded()
    }

}


// MARK: - item按钮点击时事件
extension PublishTextViewController {

    @objc fileprivate func backToPreVC() {
        dismiss(animated: true, completion: nil)
    }
    @objc fileprivate func addtag() {
        let vc = PublishTagViewController()
        //在这里拿到传回来的文字, 做成没有图片的按钮, 计算尺寸
        vc.finishedBlock = { btns in
            for btn in btns {
                let btn2 = PublishTagBtn.init(false)
                btn2.setTitle(btn.currentTitle, for: .normal)
                 self.tagButtons.append(btn2)
            }
            self.setTagButtonsFrame(self.tagButtons)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
