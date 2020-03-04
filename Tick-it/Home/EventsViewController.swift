//
//  EventsViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 01/03/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    @IBOutlet weak var proceedOutlet: UIButton!
    
    
    @IBOutlet weak var eventTime: UILabel!
    
    
    var eventDict = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        print("eventDict",eventDict)
        
        let urlImage = (eventDict["imageUrl"] as? String)!
        let url = URL(string: urlImage)
        self.image.kf.setImage(with: url)
        
        self.eventDate.text = eventDict["eventDate"] as? String
        self.eventName.text = "  \(String(describing: eventDict["eventName"]!))"
        self.eventTime.text = eventDict["eventTotalTime"] as? String
        
//          self.premiumCost.text = "\(String(describing: eventDict["platinumTicketCost"]!))$"
//        
        
        self.proceedOutlet.layer.cornerRadius = 10.0
        self.proceedOutlet.layer.masksToBounds = true
        
    }
    

    @IBAction func proceedAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "eventTickets", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventTickets"{
            let vc = segue.destination as? EventsTicketsViewController
            vc?.eventDict = eventDict
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
