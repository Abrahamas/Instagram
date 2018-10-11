//
//  HomeFeedTableViewCell.swift
//  Instagram
//
//  Created by Mac on 7/18/1397 AP.
//  Copyright © 1397 Abraham Asmile. All rights reserved.
//

import UIKit
import Parse

class HomeFeedTableViewCell: UITableViewCell {
  
    //var indexPath : IndexPath
    @IBOutlet weak var imageViewpost: UIImageView!
    
    @IBOutlet weak var informationLabelpost: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
