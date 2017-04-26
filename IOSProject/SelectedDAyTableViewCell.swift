//
//  SelectedDAyTableViewCell.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 4/14/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class SelectedDAyTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headerLbl.textColor = UIColor.white
        headerLbl.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
