//
//  ContentPicture.swift
//  BSBDJ
//
//  Created by apple on 2017/11/10.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class ContentPicture: UIView {

    @IBOutlet weak var bgView: UIImageView!

    @IBOutlet weak var pictureView: UIImageView!

    @IBOutlet weak var gifView: UIImageView!

    @IBOutlet weak var seeBigButton: UIButton!

    @IBOutlet weak var progressView: ProgressView!


    var content: ContentModel!
    override func awakeFromNib() {
        super.awakeFromNib()

        let tap = UITapGestureRecognizer(target: self, action: #selector(showPicture))
        pictureView.isUserInteractionEnabled = true
        pictureView.addGestureRecognizer(tap)
    }

    @objc private func showPicture() {



    }
    public static func picture() -> ContentPicture {
        let view = Bundle.main.loadNibNamed("ContentPicture", owner: nil, options: nil)?.first as! ContentPicture
        return view
    }

    public func setupView(_ content: ContentModel) {
        self.content = content
        let url = URL(string: content.large_image)

        pictureView.kf.setImage(with: url!, placeholder: nil, options: nil, progressBlock: { (receivedSize, expectedSize) in
            self.progressView.isHidden = false

            let progress: Double = 1.0 * Double(receivedSize) / Double(expectedSize)

            self.progressView.setProgress(progress, duration: 0)

        }) { (image, error, cache, url) in

            self.progressView.isHidden = true

            if !content.isBigPicture { return }

            // 开启图形上下文
            UIGraphicsBeginImageContextWithOptions(content.pictureFrame.size, true, 0.0)

            // 将下载完的image对象绘制发哦图形上下文
            let width = content.pictureFrame.width
            guard let picture = image else {
                return
            }
            let height = width * picture.size.height / picture.size.width
            picture.draw(in: CGRect(x: 0, y: 0, width: width, height: height))

            // 获取图片
            self.pictureView.image = UIGraphicsGetImageFromCurrentImageContext()

            UIGraphicsEndImageContext()
        }
        // 是否显示gif图片
        gifView.isHidden = !content.large_image.hasSuffix("gif")

        seeBigButton.isHidden = !content.isBigPicture



    }

}
