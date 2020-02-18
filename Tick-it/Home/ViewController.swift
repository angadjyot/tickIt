//
//  ViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 10/02/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var phoenNo: UITextField!
    @IBOutlet weak var otp: UITextField!
    @IBOutlet weak var loginOutlet: UIButton!
    @IBOutlet weak var googleSignUp: UIButton!
    @IBOutlet weak var signUpOutlet: UIButton!
    
    var veriId = ""
    let defaults = UserDefaults.standard
    var indicator = UIActivityIndicatorView()
    var db:Firestore?
    
    var userDict = [String:AnyObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.otp.isHidden = true
        
        activityIndicator()
        
        loginOutlet.layer.cornerRadius = 10.0
        loginOutlet.layer.borderWidth  = 1.0
        loginOutlet.layer.borderColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha:  255/255).cgColor
        
        googleSignUp.layer.cornerRadius = 10.0
        googleSignUp.layer.borderWidth  = 1.0
        googleSignUp.layer.borderColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha:  255/255).cgColor
        
        
    }


    
    @IBAction func loginAction(_ sender: UIButton) {
        
        if loginOutlet.titleLabel?.text == "Login"{
            self.indicator.startAnimating()
            let phoneno = "+1"+phoenNo.text!
            
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneno, uiDelegate: nil) { (verificationId, err) in
                
                if let err = err{
                    print("error is",err.localizedDescription)
                    self.indicator.stopAnimating()
                }else{
                    print("verificationId",verificationId!)
                    self.otp.isHidden = false
                    self.veriId = verificationId!
                    self.loginOutlet.setTitle("Otp", for: .normal)
                    self.indicator.stopAnimating()
                }
            }
        }else if loginOutlet.titleLabel?.text == "Otp"{
            signInWithOtp(verificationId: veriId, verificationCode: self.otp.text!)
        }
    }
    
//    sign function for user
    func signInWithOtp(verificationId:String,verificationCode:String){
        self.indicator.startAnimating()
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error{
                print("error is",error.localizedDescription)
                self.indicator.stopAnimating()
                let alert:UIAlertController = UIAlertController(title: "Message", message: "Your OTP is incorrect!!.", preferredStyle: .alert)
                let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
//                    self.performSegue(withIdentifier: "tickets", sender: nil)
                })
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }else{
                print("user signedIn successfully")
               // print("uid is",authResult?.user.uid)
                self.indicator.stopAnimating()
                
                let uid = authResult?.user.uid
                print("uidd is",uid!)
                
                self.defaults.set(uid, forKey: "userUid")
                self.retrieveUserInfo(uid: uid!)
            }
        }
    }
    
    
    func retrieveUserInfo(uid:String){
        db = Firestore.firestore()
        db?.collection("users").document(uid).getDocument(completion: { (snap, err) in
            
            if let error = err{
                print("error is",error.localizedDescription)
            }else{
                
                if (snap?.data()) != nil{
                    self.userDict = snap?.data() as! [String : AnyObject]
                    print("userDict",self.userDict)
                   
                    do{
                   
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let root = storyBoard.instantiateViewController(withIdentifier: "home")
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = root
                    }
                    
                    
                }else{
                    print("niiiiillllll")
                    self.performSegue(withIdentifier: "signup", sender: nil)
                }
            }
        })
    }
    
    
    @objc func activityIndicator(){
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40.0, height: 40.0))
        indicator.style = .gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    
    
    
    @IBAction func signUpWithGoogle(_ sender: UIButton) {
    }
    
    
    
//    @IBAction func signup(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "signup", sender: nil)
//    }
    
    
}

