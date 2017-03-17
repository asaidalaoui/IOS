//
//  PasswordChangeViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class PasswordChangeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassFst: UITextField!
    @IBOutlet weak var newPassScd: UITextField!
    
    var alertController: UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.oldPassword.delegate = self
        self.newPassFst.delegate = self
        self.newPassScd.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        if let oldpw = self.oldPassword.text, let newPWFst = self.newPassFst.text, let newPWScd = self.newPassScd.text {
            if checkPassWord(entry: oldpw) {
                let error = checkNewPW(fstpw: newPWFst, scdpw: newPWScd)
                if  error != ""{
                    showAlert(errorMsg: error)
                } else {
                    //New password should be good at this point
                    //Save it instead of old password in core data here
                }
            } else {
                showAlert(errorMsg: "Entred password does not match value stored in database")
            }
        }
    }
    
    func checkPassWord(entry: String) -> Bool {
        //check if value entered by user matches value in coredata.
        return false
    }
    
    func checkNewPW(fstpw: String, scdpw: String) -> String {
        if fstpw.characters.count < 8 {
            return "Please enter at least 8 characters for your password"
        } else if fstpw != scdpw {
            return "Password entries do not match. Please try again"
        }
        
        return ""
    }
    
    //display a popup alert message.
    func showAlert(errorMsg: String) {
        self.alertController = UIAlertController(title: "Error", message: "\(errorMsg)", preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        self.alertController!.addAction(OKAction)
        
        self.present(self.alertController!, animated: true, completion:nil)
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
