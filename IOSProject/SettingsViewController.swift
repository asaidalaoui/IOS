//
//  SettingsViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
//    @IBOutlet weak var design1: UIButton!

    @IBOutlet weak var slothImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        slothImage.image = #imageLiteral(resourceName: "SlothGenie")
//        design1.layer.cornerRadius = 10.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
        if segue.identifier == "configToRoutine" {
            let userRoutineTVC = segue.destination as! UserRoutineTableViewController
            userRoutineTVC.fromConfig = true
        }
    }
    

}
