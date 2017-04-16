//
//  EmptyTableViewCell.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 4/16/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var slothImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        slothImg.image = #imageLiteral(resourceName: "happySloth")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
