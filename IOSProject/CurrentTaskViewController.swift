//
//  CurrentTaskViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class CurrentTaskViewController: UIViewController {

    @IBOutlet weak var lblCurrent: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var pvController: UIPageControl!
    
    var task = Task()
    var dayArray = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pvController.numberOfPages = 2
        pvController.currentPage = 0

        // Do any additional setup after loading the view.
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: date as Date)
        let dayEntity = DayEntity(day: dayOfWeek)
        dayArray = dayEntity.getTasks()
        
        task = dayArray[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let time = task.date!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let convertedDate = dateFormatter.string(from: time as Date)
        
        lblCurrent.text = "Current Task: \(task.name)"
        timeLbl.text = "Start Time: \(convertedDate)"
        durationLbl.text = "Duration: \(task.duration)"
        detailsLbl.text = "Notes: \(task.details)"
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
