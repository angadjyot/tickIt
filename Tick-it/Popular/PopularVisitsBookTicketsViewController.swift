//
//  PopularVisitsBookTicketsViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 31/03/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase

class PopularVisitsBookTicketsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,PopularTableView {
  
    
    
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    
    @IBOutlet weak var popularTable: UITableView!
    @IBOutlet weak var bookTickets: UIButton!
    
    var popularDict = [String:AnyObject]()
    var arr = ["AdultTicket","ChildTicket","SeniorTicket"]
    var checkIndex = 0
    var counter = 0
    
    var adultTicketCount = 0
    var childTicketCount = 0
    var seniorTicketCount = 0
    
    var adultTicketCheck = false
    var childTicketCheck = false
    var seniorTicketCheck = false
    
    
    var adultTicketCost = 0
    var childTicketCost = 0
    var seniorTicketCost = 0
    
    var totalTickets = 0
    var totalTicketsCost = 0
      
    var indicator = UIActivityIndicatorView()
    var db:Firestore?
    var defaults = UserDefaults.standard
    var docId:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("popularDict h",popularDict)
        self.placeName.text = popularDict["placeName"] as? String
        self.placeAddress.text = popularDict["placeAddress"] as? String
        activityIndicator()
        
        
        self.bookTickets.layer.cornerRadius = 10.0
        self.bookTickets.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func activityIndicator(){
         indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40.0, height: 40.0))
         indicator.style = .gray
         indicator.center = self.view.center
         self.view.addSubview(indicator)
     }
     
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                 let cell = (tableView.dequeueReusableCell(withIdentifier: "cell")! as? PopularTableViewCell)!
        
        
        if indexPath.row == 0{
            
            cell.ticketType.text = arr[indexPath.row]
            cell.ticketCost.text = popularDict["adultTicket"] as? String
            
            cell.ticketCounterLabel.text = "\(self.adultTicketCount)"
            
        }else if indexPath.row == 1{
            cell.ticketType.text = arr[indexPath.row]
            cell.ticketCost.text = popularDict["childTicket"] as? String
            cell.ticketCounterLabel.text = "\(self.childTicketCount)"
            
        }else if indexPath.row == 2{
            cell.ticketType.text = arr[indexPath.row]
             cell.ticketCost.text = popularDict["seniorTicket"] as? String
            cell.ticketCounterLabel.text = "\(self.seniorTicketCount)"
        }
        
        cell.cellDelegate = self
        cell.index = indexPath
        
        return cell
    }
    

    func onClickCell(index: Int) {
           print("hello")
    }
       
    func onClickStepper(index: Int, counter: Int) {
         checkIndex = index
         print("stepper clicked",index,checkIndex)
        
         
        if checkIndex == 0{
            self.counter = counter
            print("counter is",counter)
            
            self.adultTicketCount = self.counter
            print("adultTicketCount is",adultTicketCount)
            
            self.adultTicketCheck = true
            self.popularTable.reloadData()
            
        }else if checkIndex == 1{
            self.counter = counter
            print("counter is",counter)
            
            self.childTicketCount = self.counter
            print("childTicketCount is",childTicketCount)
            
            self.childTicketCheck = true
            self.popularTable.reloadData()
            
        }else if checkIndex == 2{
            
            self.counter = counter
            print("counter is",counter)
            
            self.seniorTicketCount = self.counter
            print("seniorTicketCount is",seniorTicketCount)
            
            self.seniorTicketCheck = true
            self.popularTable.reloadData()
            
        }
        
        
    }
       
    
    func calculateAmount(){
        
       self.totalTickets = self.adultTicketCount + self.childTicketCount + self.seniorTicketCount
       print("totalTickets",totalTickets)
        
        adultTicketCost = self.adultTicketCount * Int((popularDict["adultTicket"] as? String)!)!
        print("adultTicketCost",adultTicketCost)
        
        childTicketCost = self.childTicketCount * Int((popularDict["childTicket"] as? String)!)!
        print("childTicketCost",childTicketCost)
        
        seniorTicketCost = self.seniorTicketCount * Int((popularDict["seniorTicket"] as? String)!)!
        print("seniorTicketCost",seniorTicketCost)
    
        totalTicketsCost = adultTicketCost+childTicketCost+seniorTicketCost
        
        print("totalTicketsCost",totalTicketsCost)
        
    }
    
    
    
    @IBAction func bookTicketsAction(_ sender: UIButton) {
        
        if self.adultTicketCount == 0 && self.childTicketCount == 0 && self.seniorTicketCount == 0{
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
            docId = (db?.collection("popularTickets").document().documentID)!
            let uid = self.defaults.string(forKey: "userUid")
            
            let timestamp = Date()
            print("timestamp",timestamp)
            
            db?.collection("popularTickets").document(docId!).setData([
                
                "popularDict":popularDict,
                
                "adultTicketCount":adultTicketCount,
                "childTicketCount":childTicketCount,
                "seniorTicketCount":seniorTicketCount,
                
                "adultTicketCost":adultTicketCost,
                "childTicketCost":childTicketCost,
                "seniorTicketCost":seniorTicketCost,
                
                "totalTicketsCost":totalTicketsCost,
                "userUid":uid!,
                "bookingTime":timestamp,
                "docId":docId!,
                "totalTickets":self.totalTickets,
                
                ]){ (err) in
                    if let error = err{
                        print(error.localizedDescription)
                    }else{
                        print("ticket booked successfully")
                        self.indicator.stopAnimating()
                        let alert:UIAlertController = UIAlertController(title: "Message", message: "Your ticket is confirmed!!", preferredStyle: .alert)
                        let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                            self.performSegue(withIdentifier: "finalTicket", sender: nil)
                        })
                        alert.addAction(alertAction)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finalTicket"{
            let vc = segue.destination as? PopularVisitsFinalTicketsViewController
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
