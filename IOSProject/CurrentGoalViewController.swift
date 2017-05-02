//
//  CurrentGoalViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class CurrentGoalViewController: UIViewController {

    
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var currentLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var pvController: UIPageControl!
    
    var goal = Goal()
    var dayArray = [Goal]()
    var gotGoal = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pvController.numberOfPages = 2
        pvController.currentPage = 1
        // Do any additional setup after loading the view.
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: date as Date)
        let dayEntity = DayEntity(day: dayOfWeek)
        dayArray = dayEntity.getGoals()
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 50, width: self.view.frame.size.width - 20, height: self.view.frame.size.height - 125))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 10.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.75
        
        self.view.addSubview(whiteRoundedView)
        self.view.sendSubview(toBack: whiteRoundedView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(dayArray.count)
        if !dayArray.isEmpty {
            for dayTask in dayArray {
                self.gotGoal = false
                if dayTask.isChecked {
                    goal = dayTask
                    self.gotGoal = true
                    break
                }
            }
        }
        
        if gotGoal {
            currentLbl.text = "Current Goal: \(goal.name!)"
            durationLbl.text = "\(goal.duration)"
            detailsLbl.text = "\(goal.details!)"
        } else {
            self.currentLbl.text = "No goal scheduled for today"
            durationLbl.text = ""
            detailsLbl.text = ""
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "createGoal") {
            let destinationVC = segue.destination as? AddTaskViewController
            destinationVC?.segControlIndex = 1
        }
    }
    

}
