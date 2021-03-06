//
//  CurrentTaskViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit
import UserNotifications

class CurrentTaskViewController: UIViewController {

    @IBOutlet weak var lblCurrent: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var pvController: UIPageControl!
    
    var task = Task()
    var dayArray = [Task]()
    var gotTask = false
    var isGrantedNotificationAccess:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pvController.numberOfPages = 2
        pvController.currentPage = 0
        pvController.pageIndicatorTintColor = UIColor.lightGray
        pvController.currentPageIndicatorTintColor = UIColor.purple

        // Do any additional setup after loading the view.
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: date as Date)
        let dayEntity = DayEntity(day: dayOfWeek)
        dayArray = dayEntity.getTasks()
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 50, width: self.view.frame.size.width - 20, height: self.view.frame.size.height - 125))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 10.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.75
        
        self.view.addSubview(whiteRoundedView)
        self.view.sendSubview(toBack: whiteRoundedView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !dayArray.isEmpty {
            for dayTask in dayArray {
                self.gotTask = false
                if dayTask.isChecked {
                    task = dayTask
                    self.gotTask = true
                    break
                }
            }
        }
        
        if gotTask {
            let time = task.date!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let convertedDate = dateFormatter.string(from: time as Date)
            
            lblCurrent.text = "Current Task: \(task.name!)"
            timeLbl.text = "\(convertedDate)"
            durationLbl.text = "\(task.duration)"
            detailsLbl.text = "\(task.details!)"
            
        } else {
            self.lblCurrent.text = "No task scheduled for today"
            
            self.timeLbl.text = ""
            self.durationLbl.text = ""
            self.detailsLbl.text = ""
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "createTask") {
            let destinationVC = segue.destination as? AddTaskViewController
            destinationVC?.segControlIndex = 0
        }
    }
    
}
