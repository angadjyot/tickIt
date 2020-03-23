//
//  SportsTicketsViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 18/03/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit

class SportsTicketsViewController: UIViewController {

    var sportDict = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func aGesture(_ sender: UITapGestureRecognizer) {
        print("aGesture")
    }
    
    
    @IBAction func bGesture(_ sender: UITapGestureRecognizer) {
        print("bGesture")
    }
   
    
    @IBAction func cGesture(_ sender: Any) {
        print("cGesture")
    }
    
    
    @IBAction func dGesture(_ sender: Any) {
        print("dGesture")
    }
    
    
    @IBAction func eGesture(_ sender: UITapGestureRecognizer) {
        print("eGesture")
    }
    
    
    @IBAction func fGesture(_ sender: Any) {
        print("fGesture")
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Tickets"{
            let vc = segue.destination as? SportsTicketBookingViewController
            vc?.sportDict = sportDict
        }
    }

    
    
    @IBAction func proceed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "Tickets", sender: nil)
        
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
