//
//  PublishTagViewController.swift
//  BSBDJ
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class PublishTagViewController: UIViewController {
    // MARK: - 控件
    lazy var textField: UITextField = {
        let tx = UITextField()
        tx.setValue(UIColor.gray, forKeyPath: "_placeholderLabel.textColor")
        tx.returnKeyType = .done
        tx.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        tx.placeholder = "编辑文字点击完成即可生成新标签"
        tx.addTarget(self, action: #selector(textChange(_:)), for: .editingChanged)
        tx.font = UIFont.systemFont(ofSize: 15.0)
        tx.delegate = self
        return tx
    }()

    lazy var tagLabel: UILabel = {
        let l = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40))
        l.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        l.textColor = UIColor.white
        l.font = UIFont.systemFont(ofSize: 15.0)
        l.isHidden = true
        self.view.addSubview(l)
        return l
    }()

    var finishedBlock: ((_ btns:[PublishTagBtn])->())?
    var tagButtons: [PublishTagBtn] = [PublishTagBtn]()
    var tagsMaxHeight:CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupnavigationItem()
         setupView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if tagButtons.count >= 3{
            tagButtons.removeSubrange(0...1)
            finishedBlock!(tagButtons)
        }
    }
    func setupView() {
        let btn1 = PublishTagBtn.init(false)
        btn1.setTitle("搞笑", for: .normal)
        let btn2 = PublishTagBtn.init(false)
        btn2.setTitle("糗事", for: .normal)
        // 3.计算button的位置
        tagButtons.append(btn1)
        tagButtons.append(btn2)
       setTagButtonsFrame(tagButtons)
    }
    fileprivate func addButton() {
        let btn = PublishTagBtn.init(true)
        btn.setTitle(textField.text, for: .normal)
        btn.addTarget(self, action: #selector(removeTag(button:)), for: .touchUpInside)
        tagButtons.append(btn)
        textField.text = "" // 清空
        let _ = setTagButtonsFrame(tagButtons)
        tagLabel.isHidden = true
    }
}



// MARK: - UITextFieldDelegate
extension PublishTagViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.hasText {
            addButton()
        }
        textField.resignFirstResponder()
        return true
    }

}



// MARK: - 点击事件的处理
extension PublishTagViewController{
    @objc fileprivate func textChange(_ textField: UITextField) {

        if textField.text!.isEmpty {
            tagLabel.isHidden = true
            return
        }
        tagLabel.isHidden = false
        tagLabel.frame = CGRect(x: 0, y: tagsMaxHeight + 5 + 40, width: kScreenWidth, height: 40)
        tagLabel.text = "添加标签:" + textField.text!
        print(tagLabel)
    }
}



// MARK: - tag标签布局
extension PublishTagViewController {
    
  fileprivate func setTagButtonsFrame(_ buttons: [PublishTagBtn]){
        //tag标签布局的宽度
        let maxWidth = (kScreenWidth - kCellTextMargin * 2)
        var maxHeight: CGFloat = 40.0
        let buttonHeight: CGFloat = 40.0
        let y: CGFloat = kCellTextMargin + kTopHeight
        for i in 0..<buttons.count {

            let button = buttons[i]
            var width = button.titleLabel!.text!.width(CGSize(width: 1000.0, height: 40.0), [NSAttributedStringKey.font: button.titleLabel?.font ?? UIFont.systemFont(ofSize: 15.0)])

            width += (kCellTextMargin + 18)
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
                let placehoderTextW = textField.placeholder!.width(CGSize(width: 1000.0, height: 40.0), [NSAttributedStringKey.font: button.titleLabel!.font])
                let textW = textField.text!.width(CGSize(width: 1000.0, height: 40.0), [NSAttributedStringKey.font: button.titleLabel!.font])

                let txFieldWidth: CGFloat = textField.text!.isEmpty ? placehoderTextW : textW

                if (previousButtonMaxX + txFieldWidth) > maxWidth {
                    textField.frame = CGRect(x: kCellTextMargin, y: maxHeight + y, width: txFieldWidth, height: 30)
                    maxHeight += buttonHeight
                }
                else {
                    textField.frame = CGRect(x: previousButtonMaxX + 10, y: maxHeight - buttonHeight + y, width: maxWidth, height: 30)
                }
                view.addSubview(textField)
            }
            view.addSubview(button)
        }
        tagsMaxHeight = maxHeight + buttonHeight
    }
}




extension PublishTagViewController {

    fileprivate func setupnavigationItem(){
    view.backgroundColor = .white
    navigationItem.title = "编辑标签"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", fontSize:15, self, #selector(publishTextNow))
    }
}












// MARK: - 按钮点击事件
extension PublishTagViewController {

    @objc fileprivate func publishTextNow() {
        navigationController?.popViewController(animated: true)
        if textField.hasText {
            addButton()
        }
    }
    @objc fileprivate func removeTag(button: PublishTagBtn) {
        button.removeFromSuperview()
        for (index, btn) in tagButtons.enumerated() {
            if btn == button{
                tagButtons.remove(at: index)
                setTagButtonsFrame(tagButtons)
            }
        }

    }
}
