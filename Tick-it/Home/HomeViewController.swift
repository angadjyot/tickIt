//
//  HomeViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 13/02/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import ImageSlideshow
import Firebase
import Kingfisher


class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var imageslideshow: ImageSlideshow!
    @IBOutlet weak var selectionCollectionView: UICollectionView!
    
    var arr = ["sdsd","sdsd","dsds","dsds"]
    var db:Firestore?
    var moviesDict = [[String:AnyObject]]()
    var eventsDict = [[String:AnyObject]]()
    var sportsDict = [[String:AnyObject]]()
    
    var dict = [String:AnyObject]()
    var eventDict = [String:AnyObject]()
    var sportDict = [String:AnyObject]()
    
    var pics = [AlamofireSource]()
    var alam:AlamofireSource!
    var slideimages = [String]()
    var defaults = UserDefaults.standard
    var selectionArr = ["Movies","Events","Sports","Popular Visits"]
    
    var selectedIndex = Int()
    var firstTimeCheck = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      imageslideshow.contentScaleMode = UIViewContentMode.scaleAspectFit
      imageslideshow.slideshowInterval = 7.0
        
        selectedIndex = 0
        print("selectedIndex view didload ",selectedIndex)
            
  
        
        imageslideshow.setImageInputs([ImageSource(image:UIImage(named:"1917-1")!), ImageSource(image: UIImage(named: "tick1")!), ImageSource(image: UIImage(named: "badboys")!)])
        
        
        self.navigationItem.title = "Movies"
        
       retrieveMovies()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == moviesCollectionView{
            if selectedIndex == 0{
                return moviesDict.count
            }else if selectedIndex == 1{
                return eventsDict.count
            }else if selectedIndex == 2{
                return sportsDict.count
            }

        }
        else if collectionView == selectionCollectionView {
            return selectionArr.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        
        if self.firstTimeCheck == true{
            print("firstTimeCheck",firstTimeCheck)
            if collectionView == moviesCollectionView{
                
                if selectedIndex == 0{
                    let index = moviesDict[indexPath.row]
                    if let movieName = index["movieImage"] as? String{
                        cell.image.layer.cornerRadius = 20.0
                        cell.image.layer.masksToBounds = true
                        let url = URL(string: movieName)
                        cell.image.kf.setImage(with: url)
                    }
                    
                    cell.movieName.text = index["movieName"] as? String
                    
                }else if selectedIndex == 1{
                    let index = eventsDict[indexPath.row]
                    if let movieName = index["imageUrl"] as? String{
                        cell.image.layer.cornerRadius = 10.0
                        cell.image.layer.masksToBounds = true
                        let url = URL(string: movieName)
                        cell.image.kf.setImage(with: url)
                    }
                    
                    cell.movieName.text = index["eventName"] as? String
                    
                }else if selectedIndex == 2{
                    
                    let index = sportsDict[indexPath.row]
                    if let movieName = index["imageUrl"] as? String{
                        cell.image.layer.cornerRadius = 10.0
                        cell.image.layer.masksToBounds = true
                        let url = URL(string: movieName)
                        cell.image.kf.setImage(with: url)
                    }
//
                    cell.movieName.text = index["sportsEventName"] as? String
                    
                }
                
          }
        }else{
            print("false")
            
            cell.selectionLabel.text = selectionArr[indexPath.row]
            cell.selectionLabel.layer.cornerRadius = 10.0
            cell.selectionLabel.layer.masksToBounds = true
            
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
        
        if collectionView == moviesCollectionView{
            
            if selectedIndex == 0{
                dict = moviesDict[indexPath.row]
                self.performSegue(withIdentifier: "movieDetail", sender: nil)
            }else if selectedIndex == 1{
                print("hello")
                eventDict = eventsDict[indexPath.row]
                self.performSegue(withIdentifier: "events", sender: nil)
//
            } else if selectedIndex == 2{
                sportDict = sportsDict[indexPath.row]
                self.performSegue(withIdentifier: "sports", sender: nil)
            }else if selectedIndex == 3{
                
            }
            
        }
    else{
            
            print("nothing")
            selectedIndex = indexPath.row
            print("selectedIndex didselect",selectedIndex)
            
            if selectedIndex == 0{
            self.navigationItem.title = "Movies"
                imageslideshow.setImageInputs([ImageSource(image:UIImage(named:"1917-1")!), ImageSource(image: UIImage(named: "tick1")!), ImageSource(image: UIImage(named: "badboys")!)])
                
            } else if selectedIndex == 1{
               
            self.navigationItem.title = "Events"
        imageslideshow.setImageInputs([ImageSource(image:UIImage(named:"PostMalone")!), ImageSource(image: UIImage(named: "NF")!), ])
                
            }else if selectedIndex == 2{
                self.navigationItem.title = "Sports"
                imageslideshow.setImageInputs([ImageSource(image:UIImage(named:"nbaFront")!), ImageSource(image: UIImage(named: "torontoFront")!), ])
                
                
            }
            
            self.moviesCollectionView.reloadData()
        }
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetail"{
            let vc = segue.destination as? MovieDetailsViewController
            vc?.movieDict = dict
        }else if segue.identifier == "events"{
            let vc = segue.destination as? EventsViewController
            vc?.eventDict = eventDict
        }else if segue.identifier == "sports"{
            let vc = segue.destination as? SportsViewController
            vc?.sportDict = sportDict
        }
    }
    
    
    
    func retrieveMovies(){
        db = Firestore.firestore()
        db?.collection("movies").getDocuments(completion: { (snap, err) in
            if let err = err{
                print("err is",err.localizedDescription)
            }else{
                
                for i in snap!.documents{
                    self.moviesDict.append(i.data() as [String : AnyObject])
                    self.slideimages.append((i.data()["movieImage"]! as? String)!)
                    
                    self.firstTimeCheck = true
                }

                
                
//                for i in 0..<self.slideimages.count{
//                    self.alam = AlamofireSource(urlString:self.slideimages[i])
//                    self.pics.append(self.alam);
//                }
//                self.imageslideshow.setImageInputs(self.pics);
//
                
//                let x = self.moviesDict["theatreList"] as? [[String:AnyObject]]
//                print("hehehe",x)
                
                
                if self.selectedIndex == 0{
                   self.moviesCollectionView.reloadData()
                }
                
                self.retrieveEvents()
                
            }
        })
    }
    
    
    
    func retrieveEvents(){
        db = Firestore.firestore()
        db?.collection("events").getDocuments(completion: { (snap, err) in
            if let err = err{
                print("err is",err.localizedDescription)
            }else{
                
                for i in snap!.documents{
                    self.eventsDict.append(i.data() as [String : AnyObject])
                }
                
                self.retrieveSportsEvents()
            }
        })
    }
    
    
    func retrieveSportsEvents(){
        db = Firestore.firestore()
        db?.collection("sports").getDocuments(completion: { (snap, err) in
            if let err = err{
                print("err is",err.localizedDescription)
            }else{
                
                for i in snap!.documents{
                    self.sportsDict.append(i.data() as [String : AnyObject])
                }
                
            }
        })
    }
    
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        
        do{
            try Auth.auth().signOut()
            self.defaults.set("", forKey: "userUid")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let root = storyBoard.instantiateViewController(withIdentifier: "main")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = root
        }catch let err{
            print("error signing out",err.localizedDescription)
            self.dismiss(animated: true, completion: nil)
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
