//
//  ProfileViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 06/04/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var phoenno: UITextField!
    @IBOutlet weak var updateOutlet: UIBarButtonItem!
    
    var defaults = UserDefaults.standard
    var db:Firestore?
    var dict = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveUserDetails()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 19/255, green: 47/255, blue: 170/255, alpha: 1/255)
        
        self.name.isEnabled = false
        self.email.isEnabled = false
        self.age.isEnabled = false
        self.phoenno.isEnabled = false
    }
    
    
    
    func retrieveUserDetails(){
        let uid = self.defaults.string(forKey: "userUid")
        print("uid is",uid!)
        db = Firestore.firestore()
        db?.collection("users").document(uid!).getDocument(completion: { (snap, err) in
            
             if let err = err{
                print("err is",err.localizedDescription)
             }else{
                
                if(snap?.data() != nil){
                  self.dict = (snap?.data() as? [String : AnyObject])!
                  print("dict is",self.dict)
                }
                
                self.name.text = self.dict["name"] as? String
                self.email.text = self.dict["email"] as? String
                self.age.text = self.dict["age"] as? String
                self.phoenno.text = self.dict["phoneNo"] as? String
             }
        })
    }
    
    
    @IBAction func updateOutlet(_ sender: UIBarButtonItem) {
        
        if updateOutlet.title == "Update"{
           self.name.isEnabled = true
           self.email.isEnabled = true
           self.age.isEnabled = true
           
           self.updateOutlet.title = "Save"
            
        }else if updateOutlet.title == "Save"{
            updateData()
        }
        
    }
    
    func updateData(){
        let uid = self.defaults.string(forKey: "userUid")
        print("uid is",uid!)
        db = Firestore.firestore()
        
        let param = ["name":self.name.text!,"email":self.email.text!,"age":self.age.text!,"phoneNo":self.dict["phoneNo"]!] as [String : Any]
        
        db?.collection("users").document(uid!).updateData(param as [String:AnyObject]){
            err in
            
            if let err = err{
                print("err",err.localizedDescription)
            }else{
                print("successfully updated")
                let alert:UIAlertController = UIAlertController(title: "Message", message: "Your profile has been updated.", preferredStyle: .alert)
               let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
             
                })
               alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
