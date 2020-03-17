//
//  EventsTicketsViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 01/03/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase

class EventsTicketsViewController: UIViewController {

    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    @IBOutlet weak var silver: UILabel!
    @IBOutlet weak var gold: UILabel!
    @IBOutlet weak var premium: UILabel!
    
    @IBOutlet weak var silverCost: UILabel!
    @IBOutlet weak var goldCost: UILabel!
    @IBOutlet weak var premiumCost: UILabel!
    @IBOutlet weak var silverStepper: UIStepper!
    @IBOutlet weak var goldStepper: UIStepper!
    @IBOutlet weak var premiumStepper: UIStepper!
    
    @IBOutlet weak var ticketButtonOutlet: UIButton!
    
    
    var eventDict = [String:AnyObject]()
    
    var silverTicketCount = 0
    var goldTicketCount = 0
    var premiumTicketCount = 0
    
    
    var silverTicketAmount = 0
    var goldTicketAmount = 0
    var premiumTicketAmount = 0
    
    var totalAmount = 0
    var totalTicket = 0

    var indicator = UIActivityIndicatorView()
    var db:Firestore?
    var defaults = UserDefaults.standard
    var docId:String?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.ticketButtonOutlet.layer.cornerRadius = 10.0
        self.ticketButtonOutlet.layer.masksToBounds = true
        
        
        self.silverCost.text = "\(String(describing: eventDict["silverTicketCost"]!))$"
        self.goldCost.text = "\(String(describing: eventDict["goldTicketCost"]!))$"
        self.premiumCost.text = "\(String(describing: eventDict["platinumTicketCost"]!))$"
        
        
        self.name.text = eventDict["eventName"] as? String
        self.date.text = eventDict["eventDate"] as? String
        self.time.text = eventDict["eventTotalTime"] as? String
        
        activityIndicator()
    }
    
    @objc func activityIndicator(){
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40.0, height: 40.0))
        indicator.style = .gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    
    @IBAction func silverStepperAction(_ sender: UIStepper) {
        self.silver.text = "\(sender.value)"
        self.silverTicketCount = Int(sender.value)
    }
    
    
    
    @IBAction func goldStepperAction(_ sender: UIStepper) {
        self.gold.text = "\(sender.value)"
        self.goldTicketCount = Int(sender.value)
    }
    
    
    
    @IBAction func premiumStepperAction(_ sender: UIStepper) {
        self.premium.text = "\(sender.value)"
        self.premiumTicketCount = Int(sender.value)
    }
    
    
    
    func calculateAmount(){
        
        
        let silver = eventDict["silverTicketCost"] as? String
        self.silverTicketAmount = self.silverTicketCount * Int(silver!)!
        
        
        let gold = eventDict["goldTicketCost"] as? String
        self.goldTicketAmount = self.goldTicketCount * Int(gold!)!

        
        let premium = eventDict["platinumTicketCost"] as? String
        self.premiumTicketAmount = self.premiumTicketCount * Int(premium!)!
        
//
        print("silverTicketAmount",silverTicketAmount)
        print("goldTicketAmount",goldTicketAmount)
        print("premiumTicketAmount",premiumTicketAmount)
//
        self.totalTicket = self.silverTicketCount+self.goldTicketCount+self.premiumTicketCount
//
//
        self.totalAmount = self.silverTicketAmount+self.goldTicketAmount+self.premiumTicketAmount
        print("totalAmount",self.totalAmount)
//
    }
    
    
    
    @IBAction func confirmTickets(_ sender: UIButton) {
        
        
        if silver.text == "0.0" || gold.text == "0.0" || premium.text == "0.0"{
            let alert:UIAlertController = UIAlertController(title: "Message", message: "Please select the number of ticket!", preferredStyle: .alert)
            let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                
            })
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)

        }else{
            calculateAmount()
            
            self.indicator.startAnimating()
            calculateAmount()
            
            db = Firestore.firestore()
            docId = (db?.collection("eventTickets").document().documentID)!
            let uid = self.defaults.string(forKey: "userUid")
            
            let timestamp = Date()
            print("timestamp",timestamp)
            
            db?.collection("eventTickets").document(docId!).setData([
                
                "eventDict":eventDict,
                //            "selectedTimings":selectedTimings!,
                //            "selectedTheatre":selectedTheatreIndex!,
                //            "selectedAddress":selectedAddress!,
                
                "silverTicketCountTotal":silverTicketCount,
                "goldTicketCountTotal":goldTicketCount,
                "platinumTicketCountTotal":premiumTicketCount,
                
                "silverTicketAmount":silverTicketAmount,
                "goldTicketAmount":goldTicketAmount,
                "premiumTicketAmount":premiumTicketAmount,
                
                "totalAmount":totalAmount,
                "userUid":uid!,
                "bookingTime":timestamp,
                "docId":docId!,
                "totalTickets":self.totalTicket,
                
                ]){ (err) in
                    if let error = err{
                        print(error.localizedDescription)
                    }else{
                        print("ticket booked successfully")
                        self.indicator.stopAnimating()
                        let alert:UIAlertController = UIAlertController(title: "Message", message: "Your ticket is confirmed!!", preferredStyle: .alert)
                        let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                            self.performSegue(withIdentifier: "eventsTicket", sender: nil)
                        })
                        alert.addAction(alertAction)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventsTicket"{
            let vc = segue.destination as? EventsTotalTicketsViewController
            vc?.docId = docId
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
