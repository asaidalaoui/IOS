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
    @IBOutlet weak var lblTaskNotes: UILabel!
    var task = Task()

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTaskName.text = task.name!
        lblTaskDue.text = "Duration: \(task.duration) hours"
        lblTaskNotes.text = "Notes: \(task.details!)"
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
        //if segue.identifier == "segueEditTask"{
        //    var destinationView = segue.destination as? AddTaskViewController
        //    destinationView?.task = self.task
        //}
        if segue.identifier == "segueEditTask"{
            let destinationView = segue.destination as! AddTaskViewController
            destinationView.isEdit = true
            destinationView.task = self.task
        }
    }
 

}
