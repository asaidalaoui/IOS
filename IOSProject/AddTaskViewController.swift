//
//  AddTaskViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

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
    var hourDuration:Int = 0
    
    func getHoursForDay(){
        let date = timeDatePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: date as Date)
        
        let hours = DayEntity(day: dayOfWeek).getSpent()
        
        lblHours.text = "\(dayOfWeek) remaining hours: \(hours)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Add/Edit Task"
        txtDuration?.keyboardType = UIKeyboardType.decimalPad
        txtDescription.text = "Add notes here..."
        timeDatePicker.maximumDate = Calendar.current.date(byAdding: .day, value: +7, to: Date())
        
        getHoursForDay()
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
        getHoursForDay()
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        hourDuration = Int(txtDuration.text!)!
        
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
