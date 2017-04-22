//
//  TodaysTaskTableViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class TodaysTaskTableViewController: UITableViewController {
    
    var taskArray = [Task]()
    var goalArray = [Goal]()
    var showtoday = true
    var dayOfWeek = ""
    var fromWeekly = false

    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.backBarButtonItem = nil
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        //Two possible cases. Either we are checking today's tasks list, or the day
        //corresponding to the selected day on the weekly view
        //Logic might need to be improved.
        if showtoday {
            dayOfWeek = dateFormatter.string(from: date as Date)
        } else {
            showtoday = true
        }
        
        let dayEntity = DayEntity(day: dayOfWeek)
        taskArray = dayEntity.getTasks()
        goalArray = dayEntity.getGoals()
        
        //show the exact number of rows created
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.backgroundColor = UIColor.lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if taskArray.count == 0 && goalArray.count == 0 {
            return 2
        }
        return goalArray.count + taskArray.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //generate the cell with the add task button
        if indexPath.row == 0 {
            if fromWeekly {
                let cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath) as! SelectedDAyTableViewCell
                cell.headerLbl.text = "\(dayOfWeek)"
                fromWeekly = false
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath)
                return cell
            }
        }
        
        if taskArray.count == 0 && goalArray.count == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptySchedule", for: indexPath)
            return cell
        } else if taskArray.count != 0 && indexPath.row < taskArray.count + 1 {
            //generate the cell with the task's details button
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TodaysTaskTableViewCell
            
            let idx = indexPath.row - 1
            cell.task = self.taskArray[idx]
            
            cell.taskNameLbl.text = self.taskArray[idx].name!
            let time = self.taskArray[idx].date!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let convertedDate = dateFormatter.string(from: time as Date)
            cell.taskTimeLbl.text = "Start @ "+convertedDate
            
            if(taskArray[idx].isChecked){
                cell.taskSwitch.setOn(true, animated: true)
            }
            else{
                cell.taskSwitch.setOn(false, animated: true)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as! TodaysGoalTableViewCell
            
            let idx = indexPath.row - 1 - taskArray.count
            cell.goal = self.goalArray[idx]
            cell.goalName.text = self.goalArray[idx].name!
            
            if (goalArray[idx].isChecked) {
                cell.goalSwitch.setOn(true, animated: true)
            } else {
                cell.goalSwitch.setOn(false, animated: true)
            }
            
            return cell
        }
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if taskArray.count == 0 && goalArray.count == 0 && indexPath.row == 1 {
            return 131
        }
        
        if indexPath.row != 0 {
            return 80
        }
        
        return 60
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueDailyToDetail" || segue.identifier == "segueWeeklyToDetail" {
            if let destinationView = segue.destination as? TaskDetailsViewController, let taskIndex = tableView.indexPathForSelectedRow?.row{
                destinationView.task = taskArray[taskIndex-1]
            }
        }
        
        else if segue.identifier == "backToWeekView"{
            if let destinationVC = segue.destination as? TabBarViewController {
                    destinationVC.index = 2
            }
        }
    }
 

}
