//
//  RegisterViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 11/02/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var register: UIButton!
    
    var db:Firestore?
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register.layer.cornerRadius = 10.0
        register.layer.masksToBounds = true
    }
    
    
    
    @IBAction func registerAction(_ sender: UIButton) {
       db = Firestore.firestore()
       let uid = self.defaults.string(forKey: "userUid")!
        let param = ["name":name.text,"phoneNo":phone.text,"email":email.text,"age":age.text]
        
        db?.collection("users").document(uid).setData(param as [String : Any]){
            err in
            
            if let err = err{
                print("err",err.localizedDescription)
            }else{
                print("successfully added")
                self.performSegue(withIdentifier: "homeVC", sender: nil)
            }
            
        }
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
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
