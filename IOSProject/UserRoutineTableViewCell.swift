//
//  UserRoutineTableViewCell.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/15/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class UserRoutineTableViewCell: UITableViewCell {

    @IBOutlet weak var weekDayLbl: UILabel!
    @IBOutlet weak var busyHours: UILabel!
    @IBOutlet weak var sleepHours: UILabel!
    
    var bhVal: Double!
    var shVal: Double!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bhVal = 0
        shVal = 0
        
        busyHours.text = "Busy: \(bhVal!) hours"
        sleepHours.text = "Sleep: \(shVal!) hours"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
