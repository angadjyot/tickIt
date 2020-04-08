//
//  SportsFinalTicketsViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 21/03/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase

class SportsFinalTicketsViewController: UIViewController {

    
    @IBOutlet weak var qrImage: UIImageView!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var aRow: UILabel!
    @IBOutlet weak var aRowCost: UILabel!
    
    @IBOutlet weak var bRow: UILabel!
    @IBOutlet weak var bRowCost: UILabel!
    
    @IBOutlet weak var cRow: UILabel!
    @IBOutlet weak var cRowCost: UILabel!
    
    @IBOutlet weak var dRow: UILabel!
    @IBOutlet weak var dRowCost: UILabel!
    
    @IBOutlet weak var eRow: UILabel!
    @IBOutlet weak var eRowCost: UILabel!
    
    @IBOutlet weak var fRow: UILabel!
    @IBOutlet weak var fRowCost: UILabel!
    
    @IBOutlet weak var backgroundView: UIView!
    
    var indicator = UIActivityIndicatorView()
    var db:Firestore?
    var defaults = UserDefaults.standard
    var docId:String?
    var dict = [String:AnyObject]()
    var arrDict = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOpacity = 0.5
        backgroundView.layer.shadowOffset = .zero
        backgroundView.layer.shadowRadius = 5
        backgroundView.layer.cornerRadius = 10

        
        retrieveticket()
        
    }
    

    
    func retrieveticket(){
        db = Firestore.firestore()
        db?.collection("sportsTickets").whereField("docId", isEqualTo: docId!).getDocuments(completion: { (snap, err) in
            if let err = err{
                print(err.localizedDescription)
            }else{
                
                for i in snap!.documents{
                    print("document is",i.data())
                    self.arrDict = i.data() as [String : AnyObject]
                    print("arrDict",self.arrDict)
                    
                    
                    self.dict = (i.data()["sportDict"] as? [String:AnyObject])!
                    
                    print("dict is",self.dict)
                    
                    self.name.text = self.dict["sportsEventName"] as? String
                    self.date.text = self.dict["gameDate"] as? String
                    
                    let urlImage = self.dict["imageUrl"] as? String
                    let url = URL(string: urlImage!)
                    self.image.kf.setImage(with: url)
                    
                    let img = self.generateQRCode(from: (self.dict["sportsEventName"] as? String)!)
                    self.qrImage.image = img
                    
                    self.setData()
            
                }
                
                
            }
        })
    }
    
    
    func setData(){


      if (self.arrDict["aRowTicketsCount"] as? Int == 0){

        
//        if (self.arrDict["bRowTicketsCount"] as? Int != 0){
//            self.aRow.text = "\(String(describing: self.arrDict["bRowTicketsCount"]!)) x Row B"
//
//            self.aRowCost.text = "\(self.arrDict["bRowTicketsCost"]!)$ "
//        }else{
        self.aRow.text = "\(String(describing: self.arrDict["aRowTicketsCount"]!)) x Row A"
        
        self.aRowCost.text = "\(self.arrDict["aRowTicketsCost"]!)$ "
//        }
        
      }else{
            self.aRow.text = "\(String(describing: self.arrDict["aRowTicketsCount"]!)) x Row A"

            self.aRowCost.text = "\(self.arrDict["aRowTicketsCost"]!)$ "

      }
      
      
        if (self.arrDict["bRowTicketsCount"] as? Int == 0){
            
//            if (self.arrDict["cRowTicketsCount"] as? Int != 0){
//                self.bRow.text = "\(String(describing: self.arrDict["cRowTicketsCount"]!)) x Row C"
//
//                self.bRowCost.text = "\(self.arrDict["cRowTicketsCost"]!)$ "
//            }else{
            self.bRow.text = "\(String(describing: self.arrDict["bRowTicketsCount"]!)) x Row B"
            
            self.bRowCost.text = "\(self.arrDict["bRowTicketsCost"]!)$ "
//            }
            
        }else{
            
//            if (self.arrDict["aRowTicketsCount"] as? Int == 0){
//                self.bRow.text = " "
//                self.bRowCost.text = " "
//            }else{
                self.bRow.text = "\(String(describing: self.arrDict["bRowTicketsCount"]!)) x Row B"

                self.bRowCost.text = "\(self.arrDict["bRowTicketsCost"]!)$ "
//
//            }
        }
        
        

        if (self.arrDict["cRowTicketsCount"] as? Int == 0){
            
//            if (self.arrDict["dRowTicketsCount"] as? Int != 0){
//                self.cRow.text = "\(String(describing: self.arrDict["dRowTicketsCount"]!)) x Row D"
//
//                self.cRowCost.text = "\(self.arrDict["dRowTicketsCost"]!)$ "
//            }else{
            self.cRow.text = "\(String(describing: self.arrDict["cRowTicketsCount"]!)) x Row C"
            
            self.cRowCost.text = "\(self.arrDict["cRowTicketsCost"]!)$ "
//            }
            
        }else{
//            if (self.arrDict["bRowTicketsCount"] as? Int == 0){
//                self.cRow.text = " "
//                self.cRowCost.text = " "
//            }else{
                self.cRow.text = "\(String(describing: self.arrDict["cRowTicketsCount"]!)) x Row C"
                
                self.cRowCost.text = "\(self.arrDict["cRowTicketsCost"]!)$ "
                
//            }
        }

        
        if (self.arrDict["dRowTicketsCount"] as? Int == 0){
            
//            if (self.arrDict["eRowTicketsCount"] as? Int != 0){
//                self.dRow.text = "\(String(describing: self.arrDict["eRowTicketsCount"]!)) x Row E"
//
//                self.dRowCost.text = "\(self.arrDict["eRowTicketsCost"]!)$ "
//
//            }else{

            self.dRow.text = "\(String(describing: self.arrDict["dRowTicketsCount"]!)) x Row D"
            
            self.dRowCost.text = "\(self.arrDict["dRowTicketsCost"]!)$ "
            
//            }
            
        }else{
            
//            if (self.arrDict["dRowTicketsCount"] as? Int == 0){
//                self.dRow.text = " "
//                self.dRowCost.text = " "
//            }else{
            
                self.dRow.text = "\(String(describing: self.arrDict["dRowTicketsCount"]!)) x Row D"
                
                self.dRowCost.text = "\(self.arrDict["dRowTicketsCost"]!)$ "
                
//            }
            
        }

        
        
        if (self.arrDict["eRowTicketsCount"] as? Int == 0){
       
//            if (self.arrDict["fRowTicketsCount"] as? Int != 0){
//                self.eRow.text = "\(String(describing: self.arrDict["fRowTicketsCount"]!)) x Row F"
//
//                self.eRowCost.text = "\(self.arrDict["fRowTicketsCost"]!)$ "
//
//            }else{
            self.eRow.text = "\(String(describing: self.arrDict["eRowTicketsCount"]!)) x Row E"
            
            self.eRowCost.text = "\(self.arrDict["eRowTicketsCost"]!)$ "
            
//            }
        }else{
            
//            if (self.arrDict["dRowTicketsCount"] as? Int == 0){
//                self.eRow.text = " "
//                self.eRowCost.text = " "
//            }else{
                self.eRow.text = "\(String(describing: self.arrDict["eRowTicketsCount"]!)) x Row E"
                
                self.eRowCost.text = "\(self.arrDict["eRowTicketsCost"]!)$ "
                
            //}
        }
        
        
        if (self.arrDict["fRowTicketsCount"] as? Int == 0){
            self.fRow.text = "\(String(describing: self.arrDict["fRowTicketsCount"]!)) x Row F"
            
            self.fRowCost.text = "\(self.arrDict["fRowTicketsCost"]!)$ "
        }else{
            
//            if (self.arrDict["eRowTicketsCount"] as? Int == 0){
//                self.fRow.text = " "
//                self.fRowCost.text = " "
//
//            }else{
            
                self.fRow.text = "\(String(describing: self.arrDict["fRowTicketsCount"]!)) x Row F"
                
                self.fRowCost.text = "\(self.arrDict["fRowTicketsCost"]!)$ "
                
         //   }
            
        }


        
        
        
    }
    
    
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
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
