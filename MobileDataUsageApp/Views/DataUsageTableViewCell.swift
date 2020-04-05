//
//  DataUsageCellTableViewCell.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 04/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import UIKit

class DataUsageTableViewCell: UITableViewCell {
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var mobileDataLabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageview.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setMobiledataUsageValue(_ data:MobileDataUsage) {
        imageview.isHidden = false
        self.yearLabel.text = "\(data.year)"
        self.mobileDataLabel.text = "\(data.mobileData!.truncate(to:AppConstants.decimalLength))"
        if data.hasDecremented {
            imageview.image = #imageLiteral(resourceName: "down-arrow")
        } else {
            imageview.image = #imageLiteral(resourceName: "up-arrow")
        }
        
    }
    func setMobiledataUsageQuarterValue(_ data:DataUsage) {
        self.yearLabel.text = "\(data.quarter)"
        self.mobileDataLabel.text = "\(data.mobileData.truncate(to:AppConstants.decimalLength))"
    }
    
}
