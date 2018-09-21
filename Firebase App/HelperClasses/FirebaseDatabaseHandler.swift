//
//  FirebaseDatabaseHandler.swift
//  Firebase App
//
//  Created by Tbi-Pc-22 on 05/09/18.
//  Copyright © 2018 Tbi-Pc-22. All rights reserved.
//

import UIKit
import FirebaseAuth

class FirebaseDatabaseHandler: NSObject {

   static let sharedInstance = FirebaseDatabaseHandler()
    
    func login(email: String,password: String,completionHandler: @escaping (User?,Error?) -> ())
    {
      
        Auth.auth().signIn(withEmail: email, password: password) { (user,error) in
        
            if let error = error {

                completionHandler(user, error)
            }
            else if let user = user {
               
                completionHandler(user, error)
                
            }
            
        }
    }
    
    
    func register(email: String,password: String,completionHandler: @escaping (User?,Error?) -> ())
    {
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                
                completionHandler(user, error)
                
            }
            else if let user = user {
                
                completionHandler(user, error)

                
            }
            
        })
            
        
    }
    
    func resetPassword(email: String,completionHandler: @escaping (Error?,String?) -> ())
    {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                completionHandler(error, "error")
            }
            else{
                completionHandler(error,"success")
            }
        }
        
        
    }
    
    
}
