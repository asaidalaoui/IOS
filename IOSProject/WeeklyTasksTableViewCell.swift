//
//  WeeklyTasksTableViewCell.swift
//  IOSProject
//
//  Created by Keith Wong on 4/12/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class WeeklyTasksTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDayOfWeek: UILabel!
    @IBOutlet weak var lblHrsFree: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
