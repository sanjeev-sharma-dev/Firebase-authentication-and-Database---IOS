//
//  RegisterViewController.swift
//  Firebase App
//
//  Created by Tbi-Pc-22 on 05/09/18.
//  Copyright © 2018 Tbi-Pc-22. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var databaseReference: DatabaseReference!

    @IBOutlet weak var confirmPasswordTF: DesignableUITextField!
    @IBOutlet weak var passwordTF: DesignableUITextField!
    @IBOutlet weak var emailTF: DesignableUITextField!
    @IBOutlet weak var usernameTF: DesignableUITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTF.delegate = self
        self.passwordTF.delegate = self
        self.usernameTF.delegate = self
        self.confirmPasswordTF.delegate = self
        
        
        databaseReference = Database.database().reference()
        

      
    }

    @IBAction func registerAction(_ sender: Any) {
        
        if usernameTF.text == "" {
            GlobalUtils.sharedInstance.showAlert(viewcontroller: self, message: "You must be enter username")
        }else if emailTF.text == "" {
            GlobalUtils.sharedInstance.showAlert(viewcontroller: self, message: "You must be enter valid email")
        }else if passwordTF.text == "" {
            GlobalUtils.sharedInstance.showAlert(viewcontroller: self, message: "You must be enter password")
        }else if confirmPasswordTF.text != passwordTF.text{
            GlobalUtils.sharedInstance.showAlert(viewcontroller: self, message: "Password doesn't match")
        }else {
            
            GlobalUtils.sharedInstance.showLoader()
            
            FirebaseDatabaseHandler.sharedInstance.register(email: emailTF.text!, password: passwordTF.text!, completionHandler: { (user, error) in
                
                GlobalUtils.sharedInstance.hideLoader()
                
                if let error = error {
                    
                    print("Error : \(error.localizedDescription)")
                    GlobalUtils.sharedInstance.showAlert(viewcontroller: self, message: error.localizedDescription)
                    
                }
                else if user != nil  {
                 
                    let parent = self.databaseReference.child("Users").childByAutoId()
                    parent.child(Constants.sharedInstance.UID).setValue(user?.uid)
                    parent.child(Constants.sharedInstance.USERNAME).setValue(self.usernameTF.text)
                    parent.child(Constants.sharedInstance.EMAIL_ID).setValue(self.emailTF.text)
                    parent.child(Constants.sharedInstance.PASSWORD).setValue(self.passwordTF.text)
                    
                    let preferences = UserDefaults.standard
                    
                    preferences.set(self.emailTF.text, forKey: Constants.sharedInstance.EMAIL_ID)
                    preferences.set(self.emailTF.text, forKey: Constants.sharedInstance.USERNAME)
                    preferences.set(self.emailTF.text, forKey: Constants.sharedInstance.PASSWORD)
                    preferences.set(user?.uid, forKey: Constants.sharedInstance.UID)
                    preferences.synchronize()
                    
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let tabbarController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                    self.navigationController?.pushViewController(tabbarController, animated: true)
                    
                    
                }
                
                
            })
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
          self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
   
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            textField.resignFirstResponder()
            return true
            
            
        case 1:
            textField.resignFirstResponder()
            return true
            
        case 2:
            textField.resignFirstResponder()
            return true
            
        case 3:
            textField.resignFirstResponder()
            return true
            
            
        default:
            return false
        }
    }
    
   

}
