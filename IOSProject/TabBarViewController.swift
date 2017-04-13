//
//  TabBarViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 4/13/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var recoverWeeklyView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if recoverWeeklyView {
            self.tabBarController?.selectedIndex = 2
            recoverWeeklyView = false
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
