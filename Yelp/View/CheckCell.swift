//
//  CheckCell.swift
//  Yelp
//
//  Created by nguyen trung quang on 3/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class CheckCell: UITableViewCell {
    @IBOutlet weak var chilContentView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgCheck: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None

        chilContentView.layer.masksToBounds = false;
        chilContentView.layer.cornerRadius = 5;
        chilContentView.layer.borderWidth = 0.3
        chilContentView.layer.borderColor = UIColor.grayColor().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var distance: DistanceModel!{
        didSet{
            lblName.text = distance.name
            imgCheck.hidden = !distance.isSelect
        }
    }
    var sortBy: SortByModel!{
        didSet{
            lblName.text = sortBy.name
            imgCheck.hidden = !sortBy.isSelect
        }
    }

}
