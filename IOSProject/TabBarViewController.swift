//
//  TabBarViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 4/13/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var index = 0
    
    var recoverWeeklyView = false
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.backBarButtonItem = nil
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if index != 0 {
            self.selectedIndex = index
            index = 0
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
