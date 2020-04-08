//
//  MyPurchasesViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 07/04/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase


class MyPurchasesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var selectionCollectionView: UICollectionView!
    
    @IBOutlet weak var selectionTableView: UITableView!
    
    
    var selectionArr = ["Movies","Events","Sports","Popular Visits"]
    
      
    var selectedIndex = Int()
    var firstTimeCheck = false
    
    var moviesArr = [[String:AnyObject]]()
    var eventsArr = [[String:AnyObject]]()
    var sportsArr = [[String:AnyObject]]()
    var popularSportssArr = [[String:AnyObject]]()
    
    var db:Firestore?
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 0
        retrieveMoviesTicket()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 19/255, green: 47/255, blue: 170/255, alpha: 1/255)
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectionArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MyPurchasesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyPurchasesCollectionViewCell
        
        cell.name.text = selectionArr[indexPath.row]
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        print("selectedIndex didselect",selectedIndex)
        self.selectionTableView.reloadData()
    }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if selectedIndex == 0{
            return moviesArr.count
        }else if selectedIndex == 1{
            return eventsArr.count
        }else if selectedIndex == 2{
            return sportsArr.count
        }else if selectedIndex == 3{
            return popularSportssArr.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        if let view = cell.viewWithTag(5){
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.5
            view.layer.shadowOffset = .zero
            view.layer.shadowRadius = 5
            view.layer.cornerRadius = 10
        }
        
        if selectedIndex == 0{
            let index = moviesArr[indexPath.row]
            let movieDict = index["movieDict"] as? [String:AnyObject]
            print("movieDict issss",movieDict!)
            if let label1 = cell.viewWithTag(1) as? UILabel{
            label1.text = movieDict!["movieName"] as? String
            }
           if let label2 = cell.viewWithTag(2) as? UILabel{
            label2.text = movieDict!["movieTime"] as? String
            }
            if let label3 = cell.viewWithTag(3) as? UILabel{
              label3.text = index["selectedDate"] as? String
            }
        if let label4 = cell.viewWithTag(4) as? UILabel{
            label4.text = "\(String(describing: index["selectedTheatre"]!)) \(String(describing: index["selectedAddress"]!))"
                }
                       
        }else if selectedIndex == 1{
            
             let index = eventsArr[indexPath.row]
             let eventDict = index["eventDict"] as? [String:AnyObject]
                print("eventDict issss",eventDict!)
            
            if let label1 = cell.viewWithTag(1) as? UILabel{
                label1.text = eventDict!["eventName"] as? String
                }
            if let label2 = cell.viewWithTag(2) as? UILabel{
                label2.text = eventDict!["eventTotalTime"] as? String
                }
            if let label3 = cell.viewWithTag(3) as? UILabel{
                label3.text = eventDict!["eventDate"] as? String
                }
            
            if let label4 = cell.viewWithTag(4) as? UILabel{
                label4.text = "Total Tickets \(String(describing: index["totalTickets"]!)) \nTotal Amount:\(String(describing: index["totalAmount"]!))$"
                }
        }else if selectedIndex == 2{
            
             let index = sportsArr[indexPath.row]
             let sportDict = index["sportDict"] as? [String:AnyObject]
                print("sportDict issss",sportDict!)
            
            if let label1 = cell.viewWithTag(1) as? UILabel{
                label1.text = sportDict!["sportsEventName"] as? String
                }
            if let label2 = cell.viewWithTag(2) as? UILabel{
                label2.text = sportDict!["gameTime"] as? String
                }
            if let label3 = cell.viewWithTag(3) as? UILabel{
                label3.text = sportDict!["gameDate"] as? String
                }
            
            if let label4 = cell.viewWithTag(4) as? UILabel{
                label4.text = "Total Tickets \(String(describing: index["totalTickets"]!)) \nTotal Amount:\(String(describing: index["totalTicketsCost"]!))$"
                }
        }else if selectedIndex == 3{
            
             let index = popularSportssArr[indexPath.row]
             let popularDict = index["popularDict"] as? [String:AnyObject]
                print("populatDict issss",popularDict!)
            
            if let label1 = cell.viewWithTag(1) as? UILabel{
                label1.text = popularDict!["placeName"] as? String
                }
            if let label2 = cell.viewWithTag(2) as? UILabel{
                label2.text = "Total Tickets:\(String(describing: index["totalTickets"]!))"
                }
            
            if let label3 = cell.viewWithTag(3) as? UILabel{
                label3.text = "Total Tickets Cost:\(String(describing: index["totalTicketsCost"]!))"
                }
            
            if let label4 = cell.viewWithTag(4) as? UILabel{
                label4.text = "\(String(describing: popularDict!["placeAddress"]!))"
            }
        }
        return cell
     
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected")
    }
    
    
    func retrieveMoviesTicket(){
        db = Firestore.firestore()
        let uid = self.defaults.string(forKey: "userUid")
        print("uid is",uid!)
        
        db?.collection("tickets").whereField("userUid", isEqualTo: uid!).getDocuments(completion: { (snap, err) in
            if let error = err{
                print("error is",error.localizedDescription)
            }else{
                
                if snap!.documents.isEmpty == true{
                    print("documents are empty")
                }else{
                    
                    for i in snap!.documents{
                      self.moviesArr.append((i.data() as? [String:AnyObject])!)
                   }
                     //   print("moviesArr is",self.moviesArr)
                    self.selectionTableView.reloadData()
                    
                    self.retrieveEventsTicket()
                }
                
            }
        })
    }
    
    
    func retrieveEventsTicket(){
        db = Firestore.firestore()
        let uid = self.defaults.string(forKey: "userUid")
        print("uid is",uid!)
        
        db?.collection("eventTickets").whereField("userUid", isEqualTo: uid!).getDocuments(completion: { (snap, err) in
            if let error = err{
                print("error is",error.localizedDescription)
            }else{
                
                if snap!.documents.isEmpty == true{
                    print("documents are empty")
                }else{
                    
                    for i in snap!.documents{
                      self.eventsArr.append((i.data() as? [String:AnyObject])!)
                   }
                     //   print("moviesArr is",self.moviesArr)
                    self.selectionTableView.reloadData()
                    self.retrieveSportsTicket()
                }
                
            }
        })
    }
    
    func retrieveSportsTicket(){
         db = Firestore.firestore()
         let uid = self.defaults.string(forKey: "userUid")
         print("uid is",uid!)
         
         db?.collection("sportsTickets").whereField("userUid", isEqualTo: uid!).getDocuments(completion: { (snap, err) in
             if let error = err{
                 print("error is",error.localizedDescription)
             }else{
                 
                 if snap!.documents.isEmpty == true{
                     print("documents are empty")
                 }else{
                     
                     for i in snap!.documents{
                       self.sportsArr.append((i.data() as? [String:AnyObject])!)
                    }
                      //   print("moviesArr is",self.moviesArr)
                     self.selectionTableView.reloadData()
                    
                    self.retrievePopularPlacesTicket()
                 }
                 
             }
         })
     }
    
    func retrievePopularPlacesTicket(){
        db = Firestore.firestore()
        let uid = self.defaults.string(forKey: "userUid")
        print("uid is",uid!)
        
        db?.collection("popularTickets").whereField("userUid", isEqualTo: uid!).getDocuments(completion: { (snap, err) in
            if let error = err{
                print("error is",error.localizedDescription)
            }else{
                
                if snap!.documents.isEmpty == true{
                    print("documents are empty")
                }else{
                    
                    for i in snap!.documents{
                      self.popularSportssArr.append((i.data() as? [String:AnyObject])!)
                   }
                     //   print("moviesArr is",self.moviesArr)
                    self.selectionTableView.reloadData()
                }
                
            }
        })
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
