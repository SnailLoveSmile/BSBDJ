//
//  RecommendCategoryCell.swift
//  BSBDJ
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class RecommendCategoryCell: UITableViewCell {



    var model:RecommendCategoryModel! {
        didSet{
            categoryLabel.text = model.name
        }
    }


    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var redView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoryLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            categoryLabel.textColor = .red
            redView.isHidden = false
        }else {
            categoryLabel.textColor = .lightGray
            redView.isHidden = true
        }

    }
    
}
