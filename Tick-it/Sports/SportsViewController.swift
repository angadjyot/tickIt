//
//  SportsViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 03/03/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit

class SportsViewController: UIViewController {

    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var ticketsOutlet: UIButton!
    
    var sportDict = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.navigationController?.navigationBar.tintColor = UIColor.white
        print("sportDict",sportDict)
        
        let urlImage = (sportDict["imageUrl"] as? String)!
        let url = URL(string: urlImage)
        self.image.kf.setImage(with: url)
        
        self.eventDate.text = sportDict["gameDate"] as? String
        self.eventName.text = "  \(String(describing: sportDict["sportsEventName"]!))"
        self.eventTime.text = sportDict["gameTime"] as? String
        
        
        self.ticketsOutlet.layer.cornerRadius = 10.0
        self.ticketsOutlet.layer.masksToBounds = true
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tickets"{
            let vc = segue.destination as? SportsTicketBookingViewController
            vc?.sportDict = sportDict
        }
    }
    
    
    @IBAction func ticketsAction(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "tickets", sender: nil)
        
        
    }
    
    
    @IBAction func tapGes(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "ticketsView", sender: nil)
        
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
