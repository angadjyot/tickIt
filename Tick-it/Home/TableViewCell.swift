//
//  TableViewCell.swift
//  Tick-it
//
//  Created by Angadjot singh on 19/03/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit


protocol TableViewNew {
    func onClickCell(index:Int)
    func onClickStepper(index:Int,counter:Int)
}



class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var rowsLabel: UILabel!
    @IBOutlet weak var ticketCostLabel: UILabel!
    @IBOutlet weak var ticketStepper: UIStepper!
    @IBOutlet weak var ticketCountLabel: UILabel!
    
    var cellDelegate:TableViewNew?
    var index:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    @IBAction func stepper(_ sender: UIStepper){
        let x = sender.value
        print("x is",x)
        cellDelegate?.onClickStepper(index: (index?.row)!,counter: Int(x))
        
    }
    
}
