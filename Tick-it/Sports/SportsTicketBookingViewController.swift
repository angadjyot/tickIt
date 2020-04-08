//
//  SportsTicketBookingViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 19/03/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase


class SportsTicketBookingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TableViewNew {
    
    
    @IBOutlet weak var ticketsButtonOutlet: UIButton!
    @IBOutlet weak var ticketTable: UITableView!
    
    var sportDict = [String:AnyObject]()
    var arr = ["Row A","Row B","Row C","Row D","Row E","Row F"]
    var counter = 0
    var checkIndex = 0
    
    var aRowTickets = 0
    var bRowTickets = 0
    var cRowTickets = 0
    var dRowTickets = 0
    var eRowTickets = 0
    var fRowTickets = 0
    
    
    var aRowTicketsCost = 0
    var bRowTicketsCost = 0
    var cRowTicketsCost = 0
    var dRowTicketsCost = 0
    var eRowTicketsCost = 0
    var fRowTicketsCost = 0
    
    
    var aRowTicketsCheck = false
    var bRowTicketsCheck = false
    var cRowTicketsCheck = false
    var dRowTicketsCheck = false
    var eRowTicketsCheck = false
    var fRowTicketsCheck = false
    
    var totalTickets = 0
    var totalTicketsCost = 0
    
    var indicator = UIActivityIndicatorView()
    var db:Firestore?
    var defaults = UserDefaults.standard
    var docId:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            print("sportDict sportDict",sportDict)
      self.ticketsButtonOutlet.layer.cornerRadius = 10.0
      self.ticketsButtonOutlet.layer.masksToBounds = true
        
      activityIndicator()
        
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
        return 84
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = (tableView.dequeueReusableCell(withIdentifier: "cell")! as? TableViewCell)!
        
        cell.rowsLabel.text = arr[indexPath.row]
        
//        let x = sportDict["aRowCost"] as? String
//        print("x is",x)
        
        if indexPath.row == 0{
        cell.ticketCostLabel.text = "\(String(describing: sportDict["aRowCost"]!))$"
       
            cell.ticketCountLabel.text = "\(aRowTickets)"

        }else if indexPath.row == 1{
            cell.ticketCostLabel.text = "\(String(describing: sportDict["bRowCost"]!))$"
            cell.ticketCountLabel.text = "\(bRowTickets)"
        }else if indexPath.row == 2{
            cell.ticketCostLabel.text = "\(String(describing: sportDict["cRowCost"]!))$"
             cell.ticketCountLabel.text = "\(cRowTickets)"
        } else if indexPath.row == 3{
            cell.ticketCostLabel.text = "\(String(describing: sportDict["dRowCost"]!))$"
             cell.ticketCountLabel.text = "\(dRowTickets)"
        }else if indexPath.row == 4{
            cell.ticketCostLabel.text = "\(String(describing: sportDict["eRowCost"]!))$"
             cell.ticketCountLabel.text = "\(eRowTickets)"
        }else if indexPath.row == 5{
            cell.ticketCostLabel.text = "\(String(describing: sportDict["fRowCost"]!))$"
             cell.ticketCountLabel.text = "\(fRowTickets)"
        }
        
        cell.cellDelegate = self
        cell.index = indexPath
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         print("hello ddsd")
    }
    
    
    func onClickStepper(index: Int,counter:Int) {
        checkIndex = index
        print("stepper clicked",index,checkIndex)
        
        if checkIndex == 0{
            self.counter = counter
            print("counter is",counter)
            self.aRowTickets = self.counter
            print("aRowTickets",aRowTickets)
            aRowTicketsCheck = true
            self.ticketTable.reloadData()
            
        }else if checkIndex == 1{
            self.counter = counter
            print("counter is",counter)
            self.bRowTickets = self.counter
            print("bRowTickets",bRowTickets)
            bRowTicketsCheck = true
            self.ticketTable.reloadData()
            
        }else if checkIndex == 2{
            self.counter = counter
            print("counter is",counter)
            self.cRowTickets = self.counter
            print("cRowTickets",cRowTickets)
            cRowTicketsCheck = true
            self.ticketTable.reloadData()
            
        }else if checkIndex == 3{
            self.counter = counter
            print("counter is",counter)
            self.dRowTickets = self.counter
            print("dRowTickets",dRowTickets)
            dRowTicketsCheck = true
            self.ticketTable.reloadData()
            
        }else if checkIndex == 4{
            self.counter = counter
            print("counter is",counter)
            self.eRowTickets = self.counter
            print("eRowTickets",eRowTickets)
            eRowTicketsCheck = true
            self.ticketTable.reloadData()
            
        }else if checkIndex == 5{
            self.counter = counter
            print("counter is",counter)
            self.fRowTickets = self.counter
            print("fRowTickets",fRowTickets)
            fRowTicketsCheck = true
            self.ticketTable.reloadData()
        }
    }
    
    func onClickCell(index: Int) {
        print("cell clicked",index)
        print("hello")
    }
    
    
    func calculateAmount(){
        
       self.totalTickets = self.aRowTickets + self.bRowTickets + self.cRowTickets + self.dRowTickets + self.eRowTickets + self.fRowTickets
        
       print("totalTickets",totalTickets)
        
        aRowTicketsCost = self.aRowTickets * Int((sportDict["aRowCost"] as? String)!)!
        print("aRowTicketsCost",aRowTicketsCost)
        
        bRowTicketsCost = self.bRowTickets * Int((sportDict["bRowCost"] as? String)!)!
        print("bRowTicketsCost",bRowTicketsCost)
        
        cRowTicketsCost = self.cRowTickets * Int((sportDict["cRowCost"] as? String)!)!
        print("cRowTicketsCost",cRowTicketsCost)
        
        dRowTicketsCost = self.dRowTickets * Int((sportDict["dRowCost"] as? String)!)!
        print("dRowTicketsCost",dRowTicketsCost)
        
        eRowTicketsCost = self.eRowTickets * Int((sportDict["eRowCost"] as? String)!)!
        print("eRowTicketsCost",eRowTicketsCost)
        
        fRowTicketsCost = self.fRowTickets * Int((sportDict["fRowCost"] as? String)!)!
        print("fRowTicketsCost",fRowTicketsCost)
        
        
        totalTicketsCost = aRowTicketsCost+bRowTicketsCost+cRowTicketsCost+dRowTicketsCost+eRowTicketsCost+fRowTicketsCost
        
        print("totalTicketsCost",totalTicketsCost)
        
    }
    
    
    @IBAction func ticketsButtonAction(_ sender: UIButton) {
        
        if self.aRowTicketsCheck == false && self.bRowTicketsCheck == false && self.cRowTicketsCheck == false && self.dRowTicketsCheck == false && self.eRowTicketsCheck == false && self.fRowTicketsCheck == false{
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
            docId = (db?.collection("sportsTickets").document().documentID)!
            let uid = self.defaults.string(forKey: "userUid")
            
            let timestamp = Date()
            print("timestamp",timestamp)
            
            db?.collection("sportsTickets").document(docId!).setData([
                
                "sportDict":sportDict,
                
                "aRowTicketsCount":aRowTickets,
                "bRowTicketsCount":bRowTickets,
                "cRowTicketsCount":cRowTickets,
                "dRowTicketsCount":dRowTickets,
                "eRowTicketsCount":eRowTickets,
                "fRowTicketsCount":fRowTickets,
                
                
                
                "aRowTicketsCost":aRowTicketsCost,
                "bRowTicketsCost":bRowTicketsCost,
                "cRowTicketsCost":cRowTicketsCost,
                "dRowTicketsCost":dRowTicketsCost,
                "eRowTicketsCost":eRowTicketsCost,
                "fRowTicketsCost":fRowTicketsCost,
                
                
                
                
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
                            self.performSegue(withIdentifier: "Ticket", sender: nil)
                        })
                        alert.addAction(alertAction)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
            }
        }
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Ticket"{
            let vc = segue.destination as? SportsFinalTicketsViewController
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
