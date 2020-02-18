//
//  CinemasListViewController.swift
//  Tick-it
//
//  Created by Angadjot singh on 17/02/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit

class CinemasListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {


    @IBOutlet weak var theatreCV: UICollectionView!
    @IBOutlet weak var revueCV: UICollectionView!
    @IBOutlet weak var foxCV: UICollectionView!
    @IBOutlet weak var bloorCV: UICollectionView!
    @IBOutlet weak var selectSeat: UIButton!
    @IBOutlet weak var selectDate: UITextField!
    
    var movieDict = [String:AnyObject]()
    var theatreDict = [String:AnyObject]()
    var movieName = [String]()
    var movieTimings = [[String:AnyObject]]()
    
    var carletonTimings = ["1.00 PM","3.00 PM","5.00 PM","7.00 PM"]
    var revueTimings = ["2.00 PM","4.00 PM","5.00 PM","7.00 PM"]
    var foxTimings = ["2.00 PM","4.00 PM","6.00 PM","9.00 PM"]
    var bloorTimings = ["3.00 PM","5.00 PM","7.00 PM","9.00 PM"]
    
    var selectedTimings:String?
    var selectedTheatreIndex:String?
    var selectedAddress:String?
    
    var selectedTheatre = ["The Carleton Cinema","Bloor Cinema","Fox Theatre","The Revue Cinema"]
    
    var address = ["2236 Queen St E, Toronto, ON","2236 bloor St E, Toronto, ON","2236 Queen St E, Toronto, ON","2236 lawrence St E, Toronto, ON"]
    
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("moviedict is",self.movieDict)
        
        
        selectedTimings = carletonTimings[0]
        selectedTheatreIndex = selectedTheatre[0]
        selectedAddress = address[0]
        
        self.selectSeat.layer.cornerRadius = 10.0
        self.selectSeat.layer.masksToBounds = true
        
        
        selectedTimings = carletonTimings[0]
        selectedTheatreIndex = selectedTheatre[0]
        selectedAddress = address[0]
        
        showPicker()
     
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func showPicker() {
        datePicker.datePickerMode = .date
       
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(CinemasListViewController.donedatePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(CinemasListViewController.cancelDatePicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        
        
        selectDate.inputAccessoryView = toolbar
        selectDate.inputView = datePicker
        
    }
    
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        selectDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == theatreCV{
           return self.carletonTimings.count
        }else if collectionView == bloorCV{
            return self.bloorTimings.count
        }else if collectionView == foxCV{
            return self.foxTimings.count
        }else if collectionView == revueCV{
            return self.revueTimings.count
        }
        
        return 0
    }
    
    var selectedIndex = Int()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:TheatreListCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TheatreListCollectionViewCell)!
        
        if collectionView == theatreCV{
            cell.theatreName.text = carletonTimings[indexPath.row]
            cell.theatreName.layer.cornerRadius = 10.0
            cell.theatreName.layer.masksToBounds = true
            
            if selectedIndex == indexPath.row{
                cell.backgroundColor = UIColor.groupTableViewBackground
            }else{
                 cell.backgroundColor = UIColor.lightGray
            }
            
        }else if collectionView == bloorCV{
            cell.bloor.text = bloorTimings[indexPath.row]
            cell.bloor.layer.cornerRadius = 10.0
            cell.bloor.layer.masksToBounds = true
            
            if selectedIndex == indexPath.row{
                cell.backgroundColor = UIColor.groupTableViewBackground
            }else{
                cell.backgroundColor = UIColor.lightGray
            }
            
        }else if collectionView == foxCV{
            cell.fox.text = foxTimings[indexPath.row]
            cell.fox.layer.cornerRadius = 10.0
            cell.fox.layer.masksToBounds = true
            
            if selectedIndex == indexPath.row{
                cell.backgroundColor = UIColor.groupTableViewBackground
            }else{
                cell.backgroundColor = UIColor.lightGray
            }
            
        }else if collectionView == revueCV{
            cell.revue.text = revueTimings[indexPath.row]
            cell.revue.layer.cornerRadius = 10.0
            cell.revue.layer.masksToBounds = true
            
            if selectedIndex == indexPath.row{
                cell.backgroundColor = UIColor.groupTableViewBackground
            }else{
                cell.backgroundColor = UIColor.lightGray
            }
        }
        
        
        return cell
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == theatreCV{
            print("did select working")
            
            selectedIndex = indexPath.row
            selectedTimings = carletonTimings[selectedIndex]
            selectedTheatreIndex = selectedTheatre[0]
            selectedAddress = address[selectedIndex]
            print("selectedTimings",selectedTimings!,selectedTheatreIndex!)
            self.theatreCV.reloadData()
            
        }else if collectionView == bloorCV{
            print("did select working")
            
            selectedIndex = indexPath.row
            selectedTimings = bloorTimings[selectedIndex]
            selectedTheatreIndex = selectedTheatre[1]
            selectedAddress = address[selectedIndex]
            print("selectedTimings",selectedTimings!,selectedTheatreIndex!)
            self.bloorCV.reloadData()
            
        }else if collectionView == foxCV{
            print("did select working")
            
            selectedIndex = indexPath.row
            selectedTimings = foxTimings[selectedIndex]
            selectedTheatreIndex = selectedTheatre[2]
            selectedAddress = address[selectedIndex]
            print("selectedTimings",selectedTimings!,selectedTheatreIndex!)
            self.foxCV.reloadData()
            
        }else if collectionView == revueCV{
            
            selectedIndex = indexPath.row
            selectedTimings = revueTimings[selectedIndex]
            selectedTheatreIndex = selectedTheatre[3]
            selectedAddress = address[selectedIndex]
            print("selectedTimings",selectedTimings!,selectedTheatreIndex!)
            self.revueCV.reloadData()
        }
        
        
    }
    
    
    @IBAction func selectSeatAction(_ sender: UIButton) {
        
        if self.selectDate.text == ""{
            let alert:UIAlertController = UIAlertController(title: "Message", message: "Please select the date for your movie.", preferredStyle: .alert)
            let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            })
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }else{
          self.performSegue(withIdentifier: "selectSeats", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectSeats"{
            let vc = segue.destination as? SelectSeatsViewController
            vc?.movieDict = movieDict
            vc?.selectedTimings = selectedTimings
            vc?.selectedTheatreIndex = selectedTheatreIndex
            vc?.selectedAddress = selectedAddress
            vc?.dateSelected = selectDate.text
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
