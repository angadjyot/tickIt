//
//  EventsTicketsViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 01/03/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit

class EventsTicketsViewController: UIViewController {

    
    
    @IBOutlet weak var silverCost: UILabel!
    @IBOutlet weak var goldCost: UILabel!
    @IBOutlet weak var premiumCost: UILabel!
    
    
    @IBOutlet weak var silverStepper: UIStepper!
    @IBOutlet weak var goldStepper: UIStepper!
    
    @IBOutlet weak var premiumStepper: UIStepper!
    
    var eventDict = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.silverCost.text = "\(String(describing: eventDict["silverTicketCost"]!))$"
        self.goldCost.text = "\(String(describing: eventDict["goldTicketCost"]!))$"
        self.premiumCost.text = "\(String(describing: eventDict["platinumTicketCost"]!))$"
        
        
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
