//
//  UserRoutineTableViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class UserRoutineTableViewController: UITableViewController {
    var alertController:UIAlertController? = nil
    var bhTxtFld: UITextField? = nil
    var shTxtFld: UITextField? = nil
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var username: String?
    var password: String?
    
    //Save everything entered by the user once the save button is clicked
    @IBAction func clickedSave(_ sender: Any) {
        //TODO: save user's data
        print("clicked save button")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //black magic to allign the cells in order for them to fill the entirety of the screen
        self.tableView.rowHeight = (self.tableView.frame.height-2*(toolbar.frame.height+10)) / 7
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
        return 7
    }
    
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
        return cell
    }
    
    //prompt the user to input busy and sleep hours through an alert view.
    //values are saved within the cell's controller instance. Would need to
    //TODO: Needs logic to check that the total number of hours entered by the user for
    //each day is below 24h
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserRoutineTableViewCell
        
        self.alertController = UIAlertController(title: "\(cell.weekDayLbl.text!)", message: "Enter the number of hours you are busy and sleep for this day.", preferredStyle: UIAlertControllerStyle.alert)
        
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            cell.bhVal = Int((self.bhTxtFld?.text)!)
            cell.shVal = Int((self.shTxtFld?.text)!)
            cell.busyHours.text = "Busy: \((self.bhTxtFld?.text)!) hours."
            cell.sleepHours.text = "Sleep: \((self.shTxtFld?.text)!) hours."
        })
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) -> Void in
        }
        
        self.alertController!.addAction(ok)
        self.alertController!.addAction(cancel)
        
        self.alertController!.addTextField { (textField) -> Void in
            // Enter the textfield customization code here.
            self.bhTxtFld = textField
            self.bhTxtFld?.placeholder = "# busy hours"
        }
        
        self.alertController!.addTextField { (textField) -> Void in
            // Enter the textfield customization code here.
            self.shTxtFld = textField
            self.shTxtFld?.placeholder = "# sleep hours"
        }
        
        present(self.alertController!, animated: true, completion: nil)
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
