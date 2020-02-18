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

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageslideshow: ImageSlideshow!
    
    
    var arr = ["sdsd","sdsd"]
    var db:Firestore?
    var moviesDict = [[String:AnyObject]]()
    var dict = [String:AnyObject]()
    
    var pics = [AlamofireSource]()
    var alam:AlamofireSource!
    var slideimages = [String]()
    var defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      imageslideshow.contentScaleMode = UIViewContentMode.scaleAspectFit
      imageslideshow.slideshowInterval = 7.0
       retrieveMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesDict.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let index = moviesDict[indexPath.row]
//        let x = index["movieCast"]
//        print("arr is",x!)
        
        if let movieName = index["movieImage"] as? String{
            cell.image.layer.cornerRadius = 20.0
            cell.image.layer.masksToBounds = true
            let url = URL(string: movieName)
            cell.image.kf.setImage(with: url)
        }
        
        cell.movieName.text = index["movieName"] as? String
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dict = moviesDict[indexPath.row]
        self.performSegue(withIdentifier: "movieDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetail"{
            let vc = segue.destination as? MovieDetailsViewController
            vc?.movieDict = dict
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
                    
                }

                
                
                for i in 0..<self.slideimages.count{
                    self.alam = AlamofireSource(urlString:self.slideimages[i])
                    self.pics.append(self.alam);
                }
                self.imageslideshow.setImageInputs(self.pics);
                
                
//                let x = self.moviesDict["theatreList"] as? [[String:AnyObject]]
//                print("hehehe",x)
                
                
                self.collectionView.reloadData()
                
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
