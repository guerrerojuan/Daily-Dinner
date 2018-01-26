//
//  DinnerCell.swift
//  Daily Dinner
//
//  Created by Juan Guerrero on 1/5/18.
//  Copyright © 2018 Juan Guerrero. All rights reserved.
//

import UIKit
import Hero

class DinnerCell: UITableViewCell {
    
    
    @IBOutlet weak var titleBackground: UIView!
    @IBOutlet weak var dinnerUIImage: UIImageView!
    @IBOutlet weak var dinnerTitleLabel: UILabel!
    @IBOutlet weak var dinnerPrepTimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //titleBackground.roundBottomCorners()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}
