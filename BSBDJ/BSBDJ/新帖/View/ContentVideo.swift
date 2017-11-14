//
//  ContentVideo.swift
//  BSBDJ
//
//  Created by apple on 2017/11/10.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class ContentVideo: UIView {

    @IBOutlet weak var bgView: UIImageView!

    @IBOutlet weak var pictureView: UIImageView!

    @IBOutlet weak var playCountLabel: UILabel!

    @IBOutlet weak var videoTimeLabel: UILabel!

    @IBOutlet weak var palyButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        playCountLabel.layer.cornerRadius = 3;
        videoTimeLabel.layer.cornerRadius = 3;

    }

    static public func contentVideo() -> ContentVideo {
        return Bundle.main.loadNibNamed("ContentVideo", owner: nil, options: nil)?.last as! ContentVideo

    }

    public func setupView(withContent content: ContentModel) {

        let url = URL(string: content.large_image)

        pictureView.kf.setImage(with: url!)

        playCountLabel.text = "\(content.playcount)播放"

        let min = content.videotime / 60

        let second = content.videotime % 60

        videoTimeLabel.text = String(format: "%02d:%02d", min, second)


    }

}
