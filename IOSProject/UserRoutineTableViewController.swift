//
//  UserRoutineTableViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class UserRoutineTableViewController: UITableViewController {
    var bhTxtFld: UITextField? = nil
    var shTxtFld: UITextField? = nil
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var username: String?
    var password: String?
    var fromConfig: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.tableview.backgroundColor = UIColor.lightGray
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //black magic to allign the cells in order for them to fill the entirety of the screen. Or at least tries to.
        
        self.bhTxtFld?.keyboardType = UIKeyboardType.decimalPad
        self.shTxtFld?.keyboardType = UIKeyboardType.decimalPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //return the day's name corresponding to an int index
    func getDayName(rowNum: Int) -> String {
        switch(rowNum) {
        case 0: return "Monday"
        case 1: return "Tuesday"
        case 2: return "Wednesday"
        case 3: return "Thursday"
        case 4: return "Friday"
        case 5: return "Saturday"
        case 6: return "Sunday"
        default: return ""
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if (fromConfig)! {
            return 89
        } else {
            return 80
        }
    }
    
    //setup the table's cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "day", for: indexPath) as! UserRoutineTableViewCell
        
        switch(indexPath.row) {
        case 0: cell.weekDayLbl.text = "Monday"
            break
        case 1: cell.weekDayLbl.text = "Tuesday"
            break
        case 2: cell.weekDayLbl.text = "Wednesday"
            break
        case 3: cell.weekDayLbl.text = "Thursday"
            break
        case 4: cell.weekDayLbl.text = "Friday"
            break
        case 5: cell.weekDayLbl.text = "Saturday"
            break
        case 6: cell.weekDayLbl.text = "Sunday"
            break
        default: break
        }
        
        cell.contentView.backgroundColor = UIColor.clear
        
        var whiteRoundedView : UIView = UIView()
        
        if fromConfig! {
            whiteRoundedView = UIView(frame: CGRect(x: 10, y: 22, width: self.view.frame.size.width - 20, height: 60))
        } else {
            whiteRoundedView = UIView(frame: CGRect(x: 10, y: 13, width: self.view.frame.size.width - 20, height: 60))
        }
        
        
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 10.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.75
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
        cell.backgroundColor = UIColor.clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.lightGray
        cell.selectedBackgroundView = backgroundView
        
        if !(fromConfig!) {
            return cell
        } else {
            let day = DayEntity(day: getDayName(rowNum: indexPath.row))
            cell.bhVal = day.getBusy()
            cell.shVal = day.getSleep()
            cell.busyHours.text = "Busy: \(cell.bhVal!) hours"
            cell.sleepHours.text = "Sleep: \(cell.shVal!) hours"
            
            return cell
        }
        
    }
    
    //prompt the user to input busy and sleep hours through an alert view.
    //values are saved within the cell's controller instance. Would need to
    //TODO: Needs logic to check that the total number of hours entered by the user for
    //each day is below 24h
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserRoutineTableViewCell
        
        let alertController = UIAlertController(title: "\(cell.weekDayLbl.text!)", message: "Enter the number of hours you are busy and sleep for this day.", preferredStyle: UIAlertControllerStyle.alert)
        
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            
            let enteredBH = Double((self.bhTxtFld?.text)!)
            let enteredSH = Double((self.shTxtFld?.text)!)
            
            if enteredBH != nil && enteredSH != nil && self.validEntry(index: indexPath.row, bh: enteredBH!, sh: enteredSH!) {
                cell.bhVal = enteredBH!
                cell.shVal = enteredSH!
                cell.busyHours.text = "Busy: \(enteredBH!) hours"
                cell.sleepHours.text = "Sleep: \(enteredSH!) hours"
            }
            
        })
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) -> Void in
        }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        alertController.addTextField { (textField) -> Void in
            // Enter the textfield customization code here.
            self.bhTxtFld = textField
            self.bhTxtFld?.placeholder = "# busy hours"
        }
        
        alertController.addTextField { (textField) -> Void in
            // Enter the textfield customization code here.
            self.shTxtFld = textField
            self.shTxtFld?.placeholder = "# sleep hours"
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    func validEntry(index: Int, bh: Double, sh: Double) -> Bool {
        var newSpentHours = bh + sh
        if (fromConfig)! {
            let day = DayEntity(day: getDayName(rowNum: index))
            newSpentHours = day.getSpent() - day.getBusy() - day.getSleep() + bh + sh
        }
        
        if newSpentHours < 0 || newSpentHours > 24 {
            let alertController = UIAlertController(title: "Sorry...", message: "Something is wrong with the values you entered. Try to modify your schedule for this day and try again.", preferredStyle: UIAlertControllerStyle.alert)
            let cancel = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (action) -> Void in
            }
            
            alertController.addAction(cancel)
            
            present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "finishSetup" && !self.fromConfig! {
            return showAlert()
        }
        
        return true
    }
    
    func showAlert() -> Bool {
        let alertController = UIAlertController(title: "Congrats!", message:
            "You finished setting up your account. You can update your routine at anytime through the Settings tab", preferredStyle: UIAlertControllerStyle.alert)
        
        let yes = UIAlertAction(title: "Start PROcrastinating", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: "finishSetup", sender: nil)
            
        })
        
        alertController.addAction(yes)
        
        self.present(alertController, animated: true, completion:nil)
        
        return true
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
    //called after shouldPerformSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if !(fromConfig!) {
            UserDefaults.standard.set(username!, forKey: "curUser")
            UserEntity().add(name: username!, password: password!)
        }
        //tableView.indexPathsForVisibleRows: returns an array of indexpath objects which will help access the cell object.
        //tableView.cellForRow(at: <#T##IndexPath#>): returns the cell object given an indexpath reference.
        
        let indexPaths: [IndexPath] = tableView.indexPathsForVisibleRows!
        for index in indexPaths {
            let cell = tableView.cellForRow(at: index) as! UserRoutineTableViewCell
            print("Row \(index.row) busy \(cell.bhVal) sleep \(cell.shVal)")
            let day = DayEntity(day: getDayName(rowNum: index.row))
            _ = day.setBusy(busyHours: cell.bhVal!)
            _ = day.setSleep(sleepHours: cell.shVal!)
        }
    }
    
    //dismissing the keyboard when pressing anywhere else on the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.bhTxtFld?.resignFirstResponder()
        self.shTxtFld?.resignFirstResponder()
        return true
    }
}
