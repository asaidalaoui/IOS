//
//  TaskDetailsViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController {
    
    @IBOutlet weak var lblTaskName: UILabel!
    @IBOutlet weak var lblTaskDue: UILabel!
    @IBOutlet weak var txtvwTaskNotes: UITextView!
    
    var task = Task()
    var day: DayEntity!

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTaskName.text = task.name!
        lblTaskDue.text = "Duration: \(task.duration) hours"
        txtvwTaskNotes.text = "\(task.details!)"
        
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

    
    // MARK: - Navigation

    // In a storyboard-based applivarion, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueEditTask" {
            let destinationView = segue.destination as! AddTaskViewController
            destinationView.isTaskEdit = true
            destinationView.task = self.task
            destinationView.segControlIndex = 0
            destinationView.enableSegControl = false
        } else if segue.identifier == "deleteSeg" {
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "deleteSeg" {
            return showAlert()
        }
        
        return true
    }
    
    func showAlert() -> Bool {
        let alertController = UIAlertController(title: "Delete", message: "Are you sure you would like to delete this taks?", preferredStyle: UIAlertControllerStyle.alert)
        
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            _ = self.day.removeTask(task: self.task)
            self.performSegue(withIdentifier: "deleteSeg", sender: nil)
            
        })
        
        let no = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) { (action) -> Void in
        }
        
        alertController.addAction(yes)
        alertController.addAction(no)
        
        self.present(alertController, animated: true, completion:nil)
        
        return false
    }
 

}
