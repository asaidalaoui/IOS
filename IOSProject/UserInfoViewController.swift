//
//  UserInfoViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userNameTxtFld: UITextField!
    @IBOutlet weak var fstPwEntryTxtLbl: UITextField!
    @IBOutlet weak var scdPwEntryTxtLbl: UITextField!
    @IBOutlet weak var design1: UIButton!
    
    var alertController: UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design1.layer.cornerRadius = 10
        
        self.userNameTxtFld.delegate = self
        self.fstPwEntryTxtLbl.delegate = self
        self.scdPwEntryTxtLbl.delegate = self
        self.fstPwEntryTxtLbl.isSecureTextEntry = true
        self.scdPwEntryTxtLbl.isSecureTextEntry = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //called after shouldPerformSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "routineSetupSeg"){
            let userRoutineTVC = segue.destination as! UserRoutineTableViewController
            userRoutineTVC.username = userNameTxtFld.text
            userRoutineTVC.password = fstPwEntryTxtLbl.text
            userRoutineTVC.fromConfig = false
        }
    }
    
    //Perform checks prior to prepare for segue.
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "routineSetupSeg" {
                let errorMsg = performChecks()
                if errorMsg != "" {
                    showAlert(errorMsg: errorMsg)
                    return false
                }
            }
        }
        return true
    }
    
    func performChecks() -> String{
        /*
         Check user name is not taken
         Check for password: first and second entries match, 8 characters long
         Possible to elaborate more the password logic in the future.
         */
        if let pw1 = fstPwEntryTxtLbl.text, let pw2 = scdPwEntryTxtLbl.text, let name = userNameTxtFld.text {
            if name == "" {
                return "Invalid username"
            } else if name == UserEntity().get(name: name).name {
                return "Username already taken"
            } else if pw1.characters.count < 8 {
                return "Please enter at least 8 characters for your password"
            } else if pw1 != pw2 {
                return "Password entries do not match. Please try again"
            }
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
    
    //dismissing the keyboard when pressing anywhere else on the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.userNameTxtFld.resignFirstResponder()
        self.fstPwEntryTxtLbl.resignFirstResponder()
        self.scdPwEntryTxtLbl.resignFirstResponder()
        return true
    }
    
}
