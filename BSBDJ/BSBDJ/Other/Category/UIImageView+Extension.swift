//
//  UIImageView+Extension.swift
//  BSBDJ
//
//  Created by apple on 2017/11/6.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit
import Kingfisher


extension UIImageView {

    /// 为imageView安全赋图
    ///
    /// - Parameter imageUrl: 图片链接: string
    func setHeaderImage(_ imageUrl: String) -> Void {
        guard let url =  URL(string: imageUrl)  else {
            return
        }
        kf.setImage(with: url, placeholder: UIImage(named: "defaultUserIcon")) { (image, error, cache, url) in
           
            if image != nil {
                self.image = image?.cicleImage()
                
            }
        }

    }


}
