//
//  RecommendUserCell.swift
//  BSBDJ
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class RecommendUserCell: UITableViewCell {

    
    var model:RecommendUserModel! {
        didSet{
            myImageView.setHeaderImage(model.header)
            desLabel.text = "\(model.fans_count)"
            titleLabel.text = model.screen_name
        }
    }

    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var desLabel: UILabel!


    @IBOutlet weak var focusBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }



    @IBAction func focusBtnClicked(_ sender: UIButton) {
        
    }









    
}
