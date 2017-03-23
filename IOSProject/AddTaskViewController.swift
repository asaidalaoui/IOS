//
//  AddTaskViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UITextViewDelegate {

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

        // Do any additional setup after loading the view.
        self.title = "Add/Edit Task"
        txtDuration?.keyboardType = UIKeyboardType.decimalPad
        txtDescription.delegate = self
        txtDescription.shouldHidePlaceholderText = true
//        timeDatePicker.maximumDate = Calendar.current.date(byAdding: .day, value: +7, to: Date())
        
        //set the minimum and maximum date for the date picker.
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: NSDate = NSDate()
        let components: NSDateComponents = NSDateComponents()
        
        components.day = +7
        
        let maxDate: NSDate = gregorian.date(byAdding: components as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
        
        self.timeDatePicker.minimumDate = currentDate as Date
        self.timeDatePicker.maximumDate = maxDate as Date
        
        _ = getHoursForDay()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        txtDescription.text = nil
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
            showAlert(errorMsg: "Missing task name")
            self.performedSave = false
            
        } else if duration == "" {
            showAlert(errorMsg: "Missing duration value")
            self.performedSave = false
            
        } else if taskDuration == nil {
            showAlert(errorMsg: "Use only numbers for duration")
            self.performedSave = false
            
        } else if  taskDuration! > freeTime {
            showAlert(errorMsg: "Task's duration much higher than time left for that day")
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
            
            let finalDay = DayEntity(day: dayOfWeek)
            _ = finalDay.addTask(name: name, date: date as NSDate, duration: duration!, details: details)
            self.performedSave = true
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
        let alertController = UIAlertController(title: "Error", message: "\(errorMsg)", preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }

}
