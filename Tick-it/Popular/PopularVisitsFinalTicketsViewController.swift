//
//  PopularVisitsFinalTicketsViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 31/03/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase


class PopularVisitsFinalTicketsViewController: UIViewController {

    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var qrcode: UIImageView!
    
    
    @IBOutlet weak var adultTicket: UILabel!
    @IBOutlet weak var adultTicketCount: UILabel!
    

    @IBOutlet weak var childTicket: UILabel!
    @IBOutlet weak var childTicketCount: UILabel!
    
    @IBOutlet weak var seniorTicket: UILabel!
    @IBOutlet weak var seniorTicketCount: UILabel!
    
    
    
    @IBOutlet weak var backgroundView: UIView!
    
      var docId:String?
      var indicator = UIActivityIndicatorView()
      var db:Firestore?
      var defaults = UserDefaults.standard
      var dict = [String:AnyObject]()
      var arrDict = [String:AnyObject]()
      
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOpacity = 0.5
        backgroundView.layer.shadowOffset = .zero
        backgroundView.layer.shadowRadius = 5
        backgroundView.layer.cornerRadius = 10
        
        self.adultTicket.text = "Adult-Ticket"
        self.childTicket.text = "Child-Ticket"
        self.seniorTicket.text = "Senior-Ticket"
        
        retrieveticket()
        
        // Do any additional setup after loading the view.
    }
    

    func retrieveticket(){
        db = Firestore.firestore()
        db?.collection("popularTickets").whereField("docId", isEqualTo: docId!).getDocuments(completion: { (snap, err) in
            if let err = err{
                print(err.localizedDescription)
            }else{
                
                for i in snap!.documents{
                    print("document is",i.data())
                    self.arrDict = i.data() as [String : AnyObject]
                    print("arrDict",self.arrDict)
                    
                    
                    self.dict = (i.data()["popularDict"] as? [String:AnyObject])!
                    
                    print("dict is",self.dict)
                    
                    self.name.text = self.dict["placeName"] as? String
                    self.address.text = self.dict["placeAddress"] as? String
                    
                    let urlImage = self.dict["placeImage"] as? String
                    let url = URL(string: urlImage!)
                    self.image.kf.setImage(with: url)
                    
                    let img = self.generateQRCode(from: (self.dict["placeName"] as? String)!)
                    self.qrcode.image = img
                    
                //    self.setData()
            
                    self.adultTicketCount.text = "\(String(describing: i.data()["adultTicketCount"]!))"
                    self.childTicketCount.text = "\(String(describing: i.data()["childTicketCount"]!))"
                    self.seniorTicketCount.text = "\(String(describing: i.data()["seniorTicketCount"]!))"
                    
                    
                }
                
                
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
