//
//  PopularTableViewCell.swift
//  Tick-it
//
//  Created by Angadjot singh on 31/03/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit

protocol PopularTableView {
    func onClickCell(index:Int)
    func onClickStepper(index:Int,counter:Int)
}


class PopularTableViewCell: UITableViewCell {

    @IBOutlet weak var ticketType: UILabel!
    @IBOutlet weak var ticketCost: UILabel!
    @IBOutlet weak var ticketCounter: UIStepper!
    @IBOutlet weak var ticketCounterLabel: UILabel!
    
    var cellDelegate:PopularTableView?
    var index:IndexPath?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        let x = sender.value
        print("x is",x)
        cellDelegate?.onClickStepper(index: (index?.row)!,counter: Int(x))
    }
    
}
