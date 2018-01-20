//
//  TableViewCell.swift
//  iOSRecruitmentTest
//
//  Created by Bazyli Zygan on 15.06.2016.
//  Copyright © 2016 Snowdog. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

    var item: AnyObject? {
        didSet {
            if item == nil {
                iconView.image = nil
                itemTitleLabel.text = "Test"
                itemDescLabel.text = "Some description"
            } else {
                guard let itemModel = item as? ItemModel else {
                    return
                }
                
                if let iconURL = URL(string: itemModel.icon) {
                    iconView.sd_setImage(with: iconURL)
                }
                
                itemTitleLabel.text = itemModel.name
                itemDescLabel.text  = itemModel.descriptionField
            }
        }
    }
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconView.layer.cornerRadius = 4
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.item = nil
    }
    
}
