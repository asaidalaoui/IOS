//
//  TodaysGoalTableViewCell.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 4/21/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class TodaysGoalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var goalSwitch: UISwitch!
    @IBOutlet weak var goalName: UILabel!
    
    var goal = Goal()
    var tile = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func switchTapped(_ sender: Any) {
        let goalEnt = GoalEntity(goal: goal)
        if goalSwitch.isOn {
            goalEnt.setChecked(isChecked: true)
            tile.alpha = 1
        } else {
            goalEnt.setChecked(isChecked: false)
            tile.alpha = 0.2
        }
    }
}
