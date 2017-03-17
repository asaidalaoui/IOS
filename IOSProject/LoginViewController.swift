//
//  LoginViewController.swift
//  IOSProject
//
//  Created by Mr. Bonobo on 3/6/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userNameTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    var alertController: UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userNameTxtFld.delegate = self
        self.passwordTxtFld.delegate = self
        self.passwordTxtFld.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //performs checks prior to segue to the next view.
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "loginSeg" {
                if let name = self.userNameTxtFld.text, let pw = self.passwordTxtFld.text {
                    if name == "" || pw == "" {
                        showAlert(errorMsg: "Missing username or password")
                        return false
                    } else if !checkCredentials() {
                        showAlert(errorMsg: "Wrong username or password")
                        return false
                    }
                }
            }
        }
        return true
    }
    
    //check entered password in passwordTxtFld against value registered in coredata for given username
    //return false if password does not match stored value.
    func checkCredentials () -> Bool {
        //TODO: implement the logic for this function.
        //return true to access user's main view
        let userEntity = UserEntity();
        let user = userEntity.get(name: userNameTxtFld.text!)
        if user.password == passwordTxtFld.text! {
            UserDefaults.standard.set(user.name, forKey:"curUser")
            return true
        }
        return false
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
        userNameTxtFld.resignFirstResponder()
        passwordTxtFld.resignFirstResponder()
        return true
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
