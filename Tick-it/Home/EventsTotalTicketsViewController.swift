//
//  EventsTotalTicketsViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 10/03/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase

class EventsTotalTicketsViewController: UIViewController {

    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var qrCode: UIImageView!
    @IBOutlet weak var silverCost: UILabel!
    @IBOutlet weak var goldCost: UILabel!
    @IBOutlet weak var platinumCost: UILabel!
    @IBOutlet weak var silver: UILabel!
    @IBOutlet weak var gold: UILabel!
    @IBOutlet weak var platinum: UILabel!
    
    var docId:String?
    var db:Firestore?
    var dict = [String:AnyObject]()
    
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
        db?.collection("eventTickets").whereField("docId", isEqualTo: docId!).getDocuments(completion: { (snap, err) in
            if let err = err{
                print(err.localizedDescription)
            }else{
                
                for i in snap!.documents{
                    print("document is",i.data())
                    
                    self.dict = (i.data()["eventDict"] as? [String:AnyObject])!
                    
                    print("dict is",self.dict)
                    
//                    self.name.text = i.data()["eventName"] as? String
//                    self.address.text = i.data()["eventDate"] as? String
//
                    self.name.text = self.dict["eventName"] as? String
                    self.address.text = self.dict["eventDate"] as? String
                    
                    let urlImage = self.dict["imageUrl"] as? String
                    let url = URL(string: urlImage!)
                    self.image.kf.setImage(with: url)
                    
                    self.silverCost.text = "\(String(describing: i["silverTicketCountTotal"]!)) x Silver Admission"
                    self.goldCost.text = "\(String(describing: i["goldTicketCountTotal"]!)) x Gold Admission"
                    self.platinumCost.text = "\(String(describing: i["platinumTicketCountTotal"]!)) x Platinum Admission"
                    
                    
                    self.silver.text = "\(self.dict["silverTicketCost"]!)$ "
                    self.gold.text = "\(self.dict["goldTicketCost"]!)$ "
                    self.platinum.text = "\(self.dict["platinumTicketCost"]!)$ "
                }
                
//                self.movie.text = self.dict["movieName"] as? String
//
                let img = self.generateQRCode(from: (self.dict["eventName"] as? String)!)
                self.qrCode.image = img
                
            }
        })
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
