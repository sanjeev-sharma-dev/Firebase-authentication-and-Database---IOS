//
//  ForgotPasswordViewController.swift
//  Firebase App
//
//  Created by Tbi-Pc-22 on 05/09/18.
//  Copyright © 2018 Tbi-Pc-22. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var emailTF: DesignableUITextField!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTF.delegate = self

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    @IBAction func resetAction(_ sender: Any) {
        
        if emailTF.text == "" {
            GlobalUtils.sharedInstance.showAlert(viewcontroller: self, message: "You must be enter the registered email address to sent you a reset password instructions.")
        }else {
            
            FirebaseDatabaseHandler.sharedInstance.resetPassword(email: emailTF.text!, completionHandler: { (error,message) in
                if  message == "error" {
                    GlobalUtils.sharedInstance.showAlert(viewcontroller: self, message: "Error : \(String(describing: error!.localizedDescription))")
                }else if message == "success"{
                    GlobalUtils.sharedInstance.showAlert(viewcontroller: self, message: "Reset password instructions sent to your registered email address, please check and follow that instructions.")
                    
                    self.emailTF.text = ""
                }
            })
            
        }
        
    }
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            textField.resignFirstResponder()
            return true
        }
        
        return false
    }
    
    
}
