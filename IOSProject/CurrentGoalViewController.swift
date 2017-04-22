//
//  CurrentGoalViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class CurrentGoalViewController: UIViewController {

    
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var currentLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var pvController: UIPageControl!
    
    var goal = Goal()
    var dayArray = [Goal]()
    var gotGoal = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pvController.numberOfPages = 2
        pvController.currentPage = 1
        // Do any additional setup after loading the view.
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: date as Date)
        let dayEntity = DayEntity(day: dayOfWeek)
        dayArray = dayEntity.getGoals()
        
        if !dayArray.isEmpty {
            for dayGoal in dayArray {
                if dayGoal.isChecked {
                    goal = dayGoal
                    self.gotGoal = true
                    break
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if gotGoal {            
            currentLbl.text = "Current Task: \(goal.name!)"
            durationLbl.text = "\(goal.duration)"
            detailsLbl.text = "\(goal.details!)"
        } else {
            self.currentLbl.text = "No task scheduled for today"
            
            self.durationLbl.isHidden = true
            self.detailsLbl.isHidden = true
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
