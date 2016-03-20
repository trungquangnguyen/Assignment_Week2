//
//  SwitchCell.swift
//  Yelp
//
//  Created by nguyen trung quang on 3/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var chilContentView: UIView!
    @IBOutlet weak var switchOn: UISwitch!

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
    
    var category: CategoryModel!{
        didSet{
            lblName.text = category.name
            switchOn.setOn(category.onSwitch, animated: false)
        }
    }
    var offer: OfferingModel!{
        didSet{
            lblName.text = offer.name
            switchOn.setOn(offer.onSwitch, animated: false)
        }
    }
    @IBAction func isOnSwitch(sender: AnyObject) {
        if category != nil {
            self.category.onSwitch = (sender as! UISwitch).on
        }
        if offer != nil {
            self.offer.onSwitch = (sender as! UISwitch).on
        }
    }
    

}
