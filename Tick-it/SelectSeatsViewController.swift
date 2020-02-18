//
//  SelectSeatsViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 17/02/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase


class SelectSeatsViewController: UIViewController {

    
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var theatreName: UILabel!
    @IBOutlet weak var theatreAddress: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    @IBOutlet weak var childTicket: UILabel!
    @IBOutlet weak var generalTicket: UILabel!
    @IBOutlet weak var general65Plus: UILabel!
    
    @IBOutlet weak var childTicketCount: UILabel!
    @IBOutlet weak var childStepper: UIStepper!
    
    @IBOutlet weak var generalTicketCount: UILabel!
    @IBOutlet weak var generalStepper: UIStepper!
                    
    @IBOutlet weak var general65PlusCount: UILabel!
    @IBOutlet weak var general65PlusStepper: UIStepper!
    
    @IBOutlet weak var checkAmount: UIButton!
    
    var indicator = UIActivityIndicatorView()
    var movieDict = [String:AnyObject]()
    var selectedTimings:String?
    var selectedTheatreIndex:String?
    var selectedAddress:String?
    var dateSelected:String?
    
    var childCost = 14
    var general = 25
    var generalPlus = 15
    
    var childTicketCountTotal = 0
    var generalTicketCountTotal = 0
    var generalPlusTicketCountTotal = 0
    
    var childTicketAmount = 0
    var generalTicketAmount = 0
    var generalPlusTicketAmount = 0
    
    var totalAmount = 0
    var totalTicket = 0
    var db:Firestore?
    
    var defaults = UserDefaults.standard
    var docId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("movie dict is",self.movieDict)
        print("date is",self.dateSelected!)

        
        self.movieName.text = movieDict["movieName"] as? String
        self.theatreName.text = selectedTheatreIndex
        self.theatreAddress.text = selectedAddress
        
        self.childTicket.text = "\(childCost)"
        self.generalTicket.text = "\(general)"
        self.general65Plus.text = "\(generalPlus)"
        self.date.text = dateSelected
        
        
        self.childTicketCount.text = "0"
        self.generalTicketCount.text = "0"
        self.general65PlusCount.text = "0"
       
        self.checkAmount.layer.cornerRadius = 10.0
        self.checkAmount.layer.masksToBounds = true
        
        activityIndicator()
        
        
    }
    
    
    
    @IBAction func childSteperAction(_ sender: UIStepper) {
        self.childTicketCount.text = "\(sender.value)"
        self.childTicketCountTotal = Int(sender.value)
        print("child",self.childTicketCountTotal)
    }
    
    
    
    @IBAction func generalStepperAction(_ sender: UIStepper) {
        self.generalTicketCount.text = "\(sender.value)"
        self.generalTicketCountTotal = Int(sender.value)
        print("general",self.generalTicketCountTotal)
    }
    
    
    @IBAction func generalPlusAction(_ sender: UIStepper) {
        self.general65PlusCount.text = "\(sender.value)"
        self.generalPlusTicketCountTotal = Int(sender.value)
        print("general65",self.generalPlusTicketCountTotal)
    }
    
    
    @IBAction func checkTotalAmount(_ sender: UIButton) {
        
        self.indicator.startAnimating()
        calculateAmount()
        
        db = Firestore.firestore()
        docId = (db?.collection("tickets").document().documentID)!
        let uid = self.defaults.string(forKey: "userUid")
        
        let timestamp = Date()
        print("timestamp",timestamp)
        
        db?.collection("tickets").document(docId!).setData([
            
            "movieDict":movieDict,
            "selectedTimings":selectedTimings!,
            "selectedTheatre":selectedTheatreIndex!,
            "selectedAddress":selectedAddress!,
            "childTicketCountTotal":childTicketCountTotal,
            "generalTicketCountTotal":generalTicketCountTotal,
            "generalPlusTicketCountTotal":generalPlusTicketCountTotal,
            "childTicketAmount":childTicketAmount,
            "generalTicketAmount":generalTicketAmount,
            "generalPlusTicketAmount":generalPlusTicketAmount,
            "totalAmount":totalAmount,
            "userUid":uid!,
            "bookingTime":timestamp,
            "docId":docId!,
            "totalTickets":self.totalTicket,
            "selectedDate":dateSelected!
        ]){ (err) in
            if let error = err{
                print(error.localizedDescription)
            }else{
                print("ticket booked successfully")
                self.indicator.stopAnimating()
                let alert:UIAlertController = UIAlertController(title: "Message", message: "Your ticket is confirmed!!", preferredStyle: .alert)
                let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.performSegue(withIdentifier: "tickets", sender: nil)
                })
                alert.addAction(alertAction)
                 self.present(alert, animated: true, completion: nil)
                
            }
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tickets"{
            let vc = segue.destination as? TicketViewController
            vc?.docId = docId
        }
    }
    @objc func activityIndicator(){
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40.0, height: 40.0))
        indicator.style = .gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    
    func calculateAmount(){
        
        self.childTicketAmount = self.childTicketCountTotal * Int(childCost)
        
        self.generalTicketAmount = self.generalTicketCountTotal * Int(general)
        
        self.generalPlusTicketAmount = self.generalPlusTicketCountTotal * Int(generalPlus)
        
        print("childTicketAmount",childTicketAmount)
        print("generalTicketAmount",generalTicketAmount)
        print("generalPlusTicketAmount",generalPlusTicketAmount)
        
        self.totalTicket = self.childTicketCountTotal+self.generalTicketCountTotal+self.generalPlusTicketCountTotal
        
        
        self.totalAmount = self.childTicketAmount+self.generalTicketAmount+self.generalPlusTicketAmount
        print("totalAmount",self.totalAmount)
        
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
