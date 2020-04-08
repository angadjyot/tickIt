//
//  PopularVisitsViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 31/03/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit

class PopularVisitsViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var placeImage: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var proceed: UIButton!
    
    var popularDict = [String:AnyObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController?.navigationBar.tintColor = UIColor.white
              print("popularDict",popularDict)
              
              let urlImage = (popularDict["placeImage"] as? String)!
              let url = URL(string: urlImage)
              self.image.kf.setImage(with: url)
              
              self.placeAddress.text = popularDict["placeAddress"] as? String
              self.placeImage.text = "\(String(describing: popularDict["placeName"]!))"
        
              
              
              self.proceed.layer.cornerRadius = 10.0
              self.proceed.layer.masksToBounds = true
        
       
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "popularTickets"{
          let vc = segue.destination as? PopularVisitsBookTicketsViewController
                vc?.popularDict = popularDict
            }
        }
     
    
    
    @IBAction func proceedAction(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "popularTickets", sender: nil)
        
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
