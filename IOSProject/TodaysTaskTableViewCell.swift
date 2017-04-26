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
    
    var task = Task()
    var tile = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func switchIsChecked(_ sender: Any) {
        let taskEnt = TaskEntity(task: task)
        if(taskSwitch.isOn){
            taskEnt.setChecked(isChecked: true)
            tile.alpha = 1
        }
        else{
            taskEnt.setChecked(isChecked: false)
            tile.alpha = 0.2
        }
    }
}
