//
//  DemoPrototypeCellTableViewCell.swift
//  Instagram
//
//  Created by Hòa Nguyễn Văn on 5/15/16.
//  Copyright © 2016 Hoa.Nguyen. All rights reserved.
//

import UIKit

class DemoPrototypeCell: UITableViewCell {

    @IBOutlet weak var imageFeed: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
