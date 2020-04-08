//
//  MovieDetailsViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 13/02/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase

class MovieDetailsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieTime: UILabel!
    @IBOutlet weak var movieType: UILabel!
    @IBOutlet weak var movieLangauge: UILabel!
    
    
    @IBOutlet weak var movieCastCollectionView: UICollectionView!
    
    @IBOutlet weak var movieCrewCollectionView: UICollectionView!
    
    
    @IBOutlet weak var bookTickets: UIButton!
    
    var movieDict = [String:AnyObject]()
    var db:Firestore?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.bookTickets.layer.cornerRadius = 10.0
        self.bookTickets.layer.masksToBounds = true
        
        
        print("movieDict",self.movieDict)
        populateData()
    }
    
    func populateData(){
        
        let urlImage = (movieDict["movieImage"] as? String)!
        let url = URL(string: urlImage)
        self.image.kf.setImage(with: url)
        
        self.movieName.text = movieDict["movieName"] as? String
        self.movieReleaseDate.text = movieDict["movieReleaseDate"] as? String
        self.movieTime.text = movieDict["movieTime"] as? String
        self.movieType.text = movieDict["movieType"] as? String
        
        if let arr = movieDict["movieLangauge"] as? NSArray{
            var concatenatedString = ""
            for i in arr{
//                concatenatedString += (i as? String)!
                concatenatedString = "\(concatenatedString),\((i as? String)!)"
                
//                concatenatedString = "\(concatenatedString)\(i) "
            }
            self.movieLangauge.text = concatenatedString
        }
        
//        self.navigationController?.title = movieDict["movieName"] as? String
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == movieCastCollectionView{
             return movieDict["movieCast"]!.count
        }else{
            return movieDict["movieCrew"]!.count
        }
        
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell:MovieCastCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MovieCastCollectionViewCell)!
        
        if collectionView == movieCastCollectionView{
            let arr = movieDict["movieCast"] as? NSArray
            cell.actorNameLabel.layer.cornerRadius = 10.0
            cell.actorNameLabel.layer.masksToBounds = true
            cell.actorNameLabel.text = arr![indexPath.row] as? String
            
        }else{
            
            let arr = movieDict["movieCrew"] as? NSArray
            cell.crewNameLabel.layer.cornerRadius = 10.0
            cell.crewNameLabel.layer.masksToBounds = true
            cell.crewNameLabel.text = arr![indexPath.row] as? String
            
        }
        
        return cell
        
    }
    
    
    @IBAction func bookTicketAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "cinemaList", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cinemaList"{
            let vc = segue.destination as? CinemasListViewController
            vc?.movieDict = movieDict
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
