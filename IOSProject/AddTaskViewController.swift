//
//  AddTaskViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var taskGoalSeg: UISegmentedControl!
    @IBOutlet weak var txtTaskName: UITextField!
    @IBOutlet weak var dayPickerView: UIPickerView!
    @IBOutlet weak var timeDatePicker: UIDatePicker!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var txtDuration: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var remainingHrsLbl: UILabel!
    
    let datePicker = UIDatePicker()
    var remainingHours:Int = 0
    var daySelected:String = ""
    var hourDuration:Double = 0
    var performedSave: Bool = true
    var segControlIndex = 0
    var enableSegControl = true
    
    var isEdit = false
    var task = Task()
    var goal = Goal()
    
    func getHoursForDay() -> Double{
        let date = timeDatePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: date as Date)
        
        let hours = 24 - DayEntity(day: dayOfWeek).getSpent()
        
        lblHours.text = "\(dayOfWeek) remaining hours: \(hours)"
        
        return hours
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.taskGoalSeg.selectedSegmentIndex = segControlIndex
        self.taskGoalSeg.isEnabled = enableSegControl

        // Do any additional setup after loading the view.
        self.title = "Add Task"
        txtDuration?.keyboardType = UIKeyboardType.decimalPad
        txtDescription.delegate = self
        txtDescription.shouldHidePlaceholderText = true
        var currentDate: NSDate = NSDate()
        
        if(isEdit){
            self.title = "Edit Task"
            txtTaskName.text = task.name!
            txtDuration.text = "\(task.duration)"
            txtDescription.text = task.details!
            currentDate = task.date!
            timeDatePicker.date = task.date! as Date
        }
        
        //set the minimum and maximum date for the date picker.
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        let components: NSDateComponents = NSDateComponents()
        
        components.day = +6
        
        let maxDate: NSDate = gregorian.date(byAdding: components as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
        
        self.timeDatePicker.minimumDate = currentDate as Date
        self.timeDatePicker.maximumDate = maxDate as Date
        
        _ = getHoursForDay()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !isEdit {
            txtDescription.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtDescription.text.isEmpty {
            txtDescription.text = "No notes entered for this task"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtTaskName.resignFirstResponder()
        txtDuration.resignFirstResponder()
        txtTaskName.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //need to grab the remaining hours for that day[row] and set it to remainingHours
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: date as Date)
        
        lblHours.text = "\(day[row]) remaining hours: \(remainingHours)"
        daySelected = day[row]
    }*/
    @IBAction func datePicker(_ sender: Any) {
        _ = getHoursForDay()
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        let freeTime = getHoursForDay()
        let duration = self.txtDuration.text
        let taskDuration = Double(duration!)
        let name = self.txtTaskName.text
        
        if name == "" {
            showAlert(errorMsg: "Missing name")
            self.performedSave = false
            
        } else if duration == "" {
            showAlert(errorMsg: "Missing duration value")
            self.performedSave = false
            
        } else if taskDuration == nil {
            showAlert(errorMsg: "Use only numbers for duration")
            self.performedSave = false
            
        } else if isEdit && (taskDuration! > freeTime + task.duration){
            showAlert(errorMsg: "Value entered for duration much higher than time left for that day")
            self.performedSave = false
        } else if !isEdit && (taskDuration! > freeTime){
            showAlert(errorMsg: "Value entered for duration much higher than time left for that day")
            self.performedSave = false
        } else {
            
            hourDuration = Double(txtDuration.text!)!
            
            //need to combine date and time? and then all these variables are to be saved to core data
            let name = txtTaskName.text!
            let details = txtDescription.text!
            let date = timeDatePicker.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let dayOfWeek = dateFormatter.string(from: date as Date)
            let duration = Double(txtDuration.text!)
            
            var taskSaved = false
            if(isEdit && taskGoalSeg.selectedSegmentIndex == 0){
                let taskEnt = TaskEntity(task: task)
                taskEnt.setName(name: name)
                taskEnt.setDate(date: date as NSDate)
                taskEnt.setDetails(details: details)
                taskEnt.setDuration(duration: duration!)
                taskEnt.setChecked(isChecked: true)
                taskSaved = true
            } else if (isEdit && taskGoalSeg.selectedSegmentIndex == 1) {
                print("EDITNG A GOAL")
                let goalEnt = GoalEntity(goal: goal)
                goalEnt.setName(name: name)
                goalEnt.setDate(date: date as NSDate)
                goalEnt.setDetails(details: details)
                goalEnt.setDuration(duration: duration!)
                goalEnt.setChecked(isChecked: true)
                taskSaved = true
            } else{
                let finalDay = DayEntity(day: dayOfWeek)
                if (taskGoalSeg.selectedSegmentIndex == 0) {
//                    print("\(name) \(duration) \(details)")
                    taskSaved = finalDay.addTask(name: name, date: date as NSDate, duration: duration!, details: details)
                } else {
                    print("ADDING NEW GOAL")
//                    print("\(name) \(duration) \(details)")
                    taskSaved = finalDay.addGoal(name: name, date: date as NSDate, duration: duration!, details: details)
                }
            }
            
            //Make sure we alert user when they try to add a task with the same name
            if taskSaved {
                self.performedSave = true
                isEdit = false
            } else {
                showAlert(errorMsg: "Task's name is already taken")
                self.performedSave = false
            }
        }
    }
    
    @IBAction func segContSelctd(_ sender: Any) {
    
        if (self.taskGoalSeg.selectedSegmentIndex == 0) {
            self.lblName.text = "Task Name:"
            self.lblDuration.text = "Task Duration:"
        } else {
            self.lblName.text = "Goal Name:"
            self.lblDuration.text = "Goal Duration:"
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
    
    //performs checks prior to segue to the next view.
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "saveSeg" {
                return self.performedSave
            }
        }
                return true
    }
    
    //display a popup alert message.
    func showAlert(errorMsg: String) {
        let alertController = UIAlertController(title: "Wait!", message: "\(errorMsg)", preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }

}
