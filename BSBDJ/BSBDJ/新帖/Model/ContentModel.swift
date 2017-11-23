//
//  ContentModel.swift
//  BSBDJ
//
//  Created by apple on 2017/11/10.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class ContentModel: NSObject {
    /**
     @property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
     */
    /// id
    var ID: String = ""
    /// 名称
    var name: String = ""
    /// 头像的URL
    var profile_image: String = ""
    /// 发帖时间
    var create_time: String = ""
    /// 文字内容
    var text: String = ""
    /// 顶的数量
    var ding: Int = 0
    /// 踩的数量
    var cai: Int = 0
    /// 转发的数量
    var repost: Int = 0
    /// 评论的数量
    var comment: Int = 0
    /// 图片的宽度
    var width: CGFloat = 0
    /// 图片的高度
    var height: CGFloat = 0
    /// 小图
    var small_image: String = ""
    /// 中图
    var middle_image: String = ""
    /// 大图
    var large_image: String = ""
    /// 播放数量
    var playcount: Int = 0
    /// 播放时长
    var voicetime: Int = 0
    /// 视频时长
    var videotime: Int = 0
    /// 类型
    var type: Int = 0

    var top_cmt:CommentModel!

    var isBigPicture: Bool = false

    /// 额外的计算cell高度的属性
    var pictureFrame: CGRect!
    var voiceFrame: CGRect!
    var videoFrame: CGRect!
    var _cellHeight: CGFloat = 0


    init(dict: [String: Any]) {
        ID = dict["id"] as? String ?? ""
          text = dict["text"] as? String ?? ""
        name = dict["name"] as? String ?? ""
        profile_image = dict["profile_image"] as? String ?? ""
        create_time = dict["create_time"] as? String ?? ""
       ding =  Int((dict["ding"] as? NSString ?? "0").intValue)
       cai =  Int((dict["cai"] as? NSString ?? "0").intValue)
        repost = dict["repost"] as? Int ?? 0
        comment = Int((dict["comment"] as? NSString ?? "0").intValue)
        width = CGFloat((dict["width"] as? NSString ?? "0").floatValue)
        height = CGFloat((dict["height"] as? NSString ?? "0").floatValue)

        playcount =  Int((dict["playcount"] as? NSString ?? "0").intValue)
        videotime =  Int((dict["videotime"] as? NSString ?? "0").intValue)
        type = Int((dict["type"] as? NSString ?? "0").intValue)
        voicetime = Int((dict["voicetime"] as? NSString ?? "0").intValue)

        small_image = dict["image0"] as? String ?? ""
        middle_image = dict["image2"] as? String ?? ""
        large_image = dict["image1"] as? String ?? ""

        if let array = dict["top_cmt"] as? [[String : Any]], array.count > 0 {
            top_cmt = CommentModel(dict: array.first!)
        }


    }







    var cellHeight: CGFloat {
        get {
            if _cellHeight == 0 {
                let t = text as NSString
                var size = CGSize(width: kScreenWidth - kCellTextMargin * 2, height: 10000)
                size = t.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13)], context: nil).size
                _cellHeight = kCellHeaderHeight + size.height + kCellFooterHeight + 2 * kCellTextMargin

                if type == ContentType.picture.rawValue {
                    // 图片显示出来的宽度
                    let pictureW: CGFloat = kScreenWidth - kCellTextMargin * 2;
                    // 显示显示出来的高度
                    var pictureH: CGFloat = pictureW * height / width;

                    if pictureH >= kCellIamgeMaxH {
                        pictureH = kCellImageBreakHeight
                        isBigPicture = true
                    }

                    pictureFrame = CGRect(x: kCellTextMargin, y: kCellHeaderHeight + size.height + 2 * kCellTextMargin , width: pictureW, height: pictureH)
                    _cellHeight += (pictureH + kCellTextMargin)
                } else if type == ContentType.voice.rawValue {
                    // 图片显示出来的宽度
                    let pictureW: CGFloat = kScreenWidth - kCellTextMargin * 2;
                    // 显示显示出来的高度
                    let pictureH: CGFloat = pictureW * height / width;

                    voiceFrame = CGRect(x: kCellTextMargin, y: kCellHeaderHeight + size.height + 2 * kCellTextMargin , width: pictureW, height: pictureH)
                    _cellHeight += (pictureH + kCellTextMargin)
                } else if type == ContentType.video.rawValue {
                    // 图片显示出来的宽度
                    let pictureW: CGFloat = kScreenWidth - kCellTextMargin * 2;
                    // 显示显示出来的高度
                    let pictureH: CGFloat = pictureW * height / width;

                    videoFrame = CGRect(x: kCellTextMargin, y: kCellHeaderHeight + size.height + 2 * kCellTextMargin , width: pictureW, height: pictureH)
                    _cellHeight += (pictureH + kCellTextMargin)
                }


                if let comment = top_cmt {
                    let text = comment.content as NSString
                    var size = CGSize(width: kScreenWidth - kCellTextMargin * 2, height: 10000)
                    size = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)], context: nil).size
                    _cellHeight = _cellHeight + 21 + size.height
                }

            }
            return _cellHeight
        }
    }
}
