//
//  TodaysTaskTableViewCell.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/22/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class TodaysTaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskSwitch: UISwitch!
    @IBOutlet weak var taskTimeLbl: UILabel!
    @IBOutlet weak var taskNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
