//
//  ViewController.swift
//  Firebase App
//
//  Created by Tbi-Pc-22 on 04/09/18.
//  Copyright © 2018 Tbi-Pc-22. All rights reserved.
//

import UIKit

import FirebaseAuth

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTF: DesignableUITextField!
    @IBOutlet weak var EmailTF: DesignableUITextField!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.EmailTF.delegate = self
        self.passwordTF.delegate = self
    }

    @IBAction func loginAction(_ sender: Any) {
        
        if EmailTF.text == "" {
           
            GlobalUtils.sharedInstance.showAlert(viewcontroller: self, message: "You must be enter  valid email Address")
       
        }else if passwordTF.text == "" {
            
             GlobalUtils.sharedInstance.showAlert(viewcontroller: self, message: "You must be enter  valid password")
       
        }else {
            
            if GlobalUtils.sharedInstance.isConnectedToNetwork() {
                
              GlobalUtils.sharedInstance.showLoader()
            
               FirebaseDatabaseHandler.sharedInstance.login(email: EmailTF.text!, password: passwordTF.text!,completionHandler: { (user, err) in
            
                if let error = err {
                    
                    print("error occurs = \(error.localizedDescription)")
                    
                    GlobalUtils.sharedInstance.showAlert(viewcontroller: self, message: error.localizedDescription)
                    
                }
                else if let user = user {
                    
                  print("user.email = \(String(describing: user.uid))")
                    
                   let preferences = UserDefaults.standard
                   preferences.set(user.email, forKey: Constants.sharedInstance.EMAIL_ID)
                   preferences.set(user.uid, forKey: Constants.sharedInstance.UID)
                   preferences.synchronize()
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let tabbarController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                    self.navigationController?.pushViewController(tabbarController, animated: true)
                    
                    
                }

                GlobalUtils.sharedInstance.hideLoader()
               
                })
                
            }else{
                
             GlobalUtils.sharedInstance.showAlert(viewcontroller: self, message: "Internet not connected")
                
            }
            
        }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
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
            
            
        default:
            return false
        }
    }
    
}

