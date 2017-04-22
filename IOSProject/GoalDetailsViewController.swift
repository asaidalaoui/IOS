//
//  GoalDetailsViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class GoalDetailsViewController: UIViewController {

    @IBOutlet weak var goalTitleLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var goalNotesTxtVw: UITextView!
    
    var goal = Goal()
    var day: DayEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goalTitleLbl.text = goal.name!
        self.durationLbl.text = String(goal.duration) + " Hours"
        self.goalNotesTxtVw.text = "Notes \(goal.details!)"
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: date as Date)
        day = DayEntity(day: dayOfWeek)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "deleteSeg" {
            return showAlert()
        }
        
        return true
    }
    
    func showAlert() -> Bool {
        let alertController = UIAlertController(title: "Delete", message: "Are you sure you would like to delete this goal?", preferredStyle: UIAlertControllerStyle.alert)
        
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            _ = self.day.removeGoal(goal: self.goal)
            self.performSegue(withIdentifier: "deleteSeg", sender: nil)
            
        })
        
        let no = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) { (action) -> Void in
        }
        
        alertController.addAction(yes)
        alertController.addAction(no)
        
        self.present(alertController, animated: true, completion:nil)
        
        return false
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editGoal" {
            let destinationView = segue.destination as! AddTaskViewController
            destinationView.isGoalEdit = true
            destinationView.goal = self.goal
            destinationView.segControlIndex = 1
            destinationView.enableSegControl = false
        }
    }
 

}
