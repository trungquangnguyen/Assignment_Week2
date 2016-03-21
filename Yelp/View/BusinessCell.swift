
//
//  BusinessCell.swift
//  Yelp
//
//  Created by nguyen trung quang on 3/19/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    // MARK: Property
    //Outlet
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var imgRepresentation: UIImageView!
    @IBOutlet weak var imgRating: UIImageView!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    
    //contrain
    
    
    // model
    var business: Business!{
        didSet{
           lblName.text = business.name
            lblDistance.text = business.distance
            faceImage(business.imageURL!, imageView: imgRepresentation)
            faceImage(business.ratingImageURL!, imageView: imgRating)
            lblReview.text =  "\(business.reviewCount!.integerValue) Reviews"
            lblAddress.text = business.address
            lblCategory.text = business.categories
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: private method
    func faceImage(url: NSURL,imageView: UIImageView){
        let imageRequest = NSURLRequest(URL: url)
        imageView.setImageWithURLRequest(
            imageRequest,
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) -> Void in
                if imageResponse != nil {
                    imageView.alpha = 0.0
                    imageView.image = image
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        imageView.alpha = 1.0
                    })
                } else {
                    imageView.image = image
                }
            },
            failure: { (imageRequest, imageResponse, error) -> Void in
                // do something for the failure condition
        })
    }

}
