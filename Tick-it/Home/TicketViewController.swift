//
//  TicketViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 17/02/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase

class TicketViewController: UIViewController {

    
    @IBOutlet weak var movie: UILabel!
    @IBOutlet weak var timings: UILabel!
    @IBOutlet weak var noOfTickets: UILabel!
    @IBOutlet weak var location: UILabel!
    
    
    @IBOutlet weak var qrImage: UIImageView!
    
    var docId:String?
    var db:Firestore?
    
    var dict = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("docId",docId!)
        
        retrieveticket()
    }
    
   func retrieveticket(){
        db = Firestore.firestore()
    db?.collection("tickets").whereField("docId", isEqualTo: docId!).getDocuments(completion: { (snap, err) in
        if let err = err{
            print(err.localizedDescription)
        }else{
            
            for i in snap!.documents{
                print("document is",i.data())
                
                self.dict = (i.data()["movieDict"] as? [String:AnyObject])!
                self.timings.text = i.data()["selectedTimings"] as? String
                
                let totalTicket = i.data()["totalTickets"] as? Int
                
                self.noOfTickets.text = "\(String(describing: totalTicket!))"
                
                self.location.text = i.data()["selectedAddress"] as? String
            }
            
            
            self.movie.text = self.dict["movieName"] as? String
            
            let img = self.generateQRCode(from: (self.dict["movieName"] as? String)!)
            self.qrImage.image = img
            
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
