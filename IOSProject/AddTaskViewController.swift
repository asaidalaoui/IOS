//
//  AddTaskViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class AddTaskViewController: UIPageViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var taskGoalSeg: UISegmentedControl!
    @IBOutlet weak var txtTaskName: UITextField!
    @IBOutlet weak var dayPickerView: UIPickerView!
    @IBOutlet weak var timeDatePicker: UIDatePicker!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var txtDuration: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    
    let day = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var remainingHours:Int = 0
    var daySelected:String = ""
    var hourDuration:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtDuration.keyboardType = UIKeyboardType.numberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return day[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return day.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblHours.text = "\(day[row]) remaining hours: \(remainingHours)"
        daySelected = day[row]
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        hourDuration = Int(txtDuration.text!)!
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
