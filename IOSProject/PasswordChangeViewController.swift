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
    @IBOutlet weak var design1: UIButton!
    
    var alertController: UIAlertController? = nil
    var didPressCancel = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design1.layer.cornerRadius = 10.0
        
        self.oldPassword.delegate = self
        self.oldPassword.isSecureTextEntry = true
        self.newPassFst.delegate = self
        self.newPassFst.isSecureTextEntry = true
        self.newPassScd.delegate = self
        self.newPassScd.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkOldPassWord(entry: String) -> Bool {
        //check if value entered by user matches value in coredata.
        let username = UserDefaults.standard.object(forKey: "curUser") as! String
        let user = UserEntity().get(name: username )
        if user.password == entry {
            return true
        }
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "cancelSeg" || segue.identifier == "pwSavedSeg") {
            let destVC = segue.destination as! TabBarViewController
            destVC.index = 3
        }
    }
 
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if identifier == "pwSavedSeg" {
            if let oldpw = self.oldPassword.text, let newPWFst = self.newPassFst.text, let newPWScd = self.newPassScd.text {
                if checkOldPassWord(entry: oldpw) {
                    let error = checkNewPW(fstpw: newPWFst, scdpw: newPWScd)
                    if  error != ""{
                        showAlert(errorMsg: error)
                        return false
                    } else {
                        //New password should be good at this point
                        //Save it instead of old password in core data here
                        let user = UserDefaults.standard.object(forKey: "curUser") as! String
                        _ = UserEntity().setPassword(name: user, password: self.newPassScd.text!)
                    }
                } else {
                    showAlert(errorMsg: "Entred password does not match value stored in database")
                    return false
                }
            }
        }
        return true
    }
   
    
    //dismissing the keyboard when pressing anywhere else on the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.oldPassword.resignFirstResponder()
        self.newPassFst.resignFirstResponder()
        self.newPassScd.resignFirstResponder()
        return true
    }

}
