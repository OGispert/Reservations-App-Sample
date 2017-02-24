//
//  ReservationCell.swift
//  MyReservations
//
//  Created by Othmar Gispert on 2/18/17.
//  Copyright © 2017 Othmar Gispert. All rights reserved.
//

import UIKit

class ReservationCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var partySizeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureCell (item: Item) { //Configure our cell with the data to be stored
        
        titleLabel.text = item.massage
        dateLabel.text = item.date
        timeLabel.text = item.time
        partySizeLabel.text = item.partySize
        durationLabel.text = item.duration
        descriptionLabel.text = item.massageDesc
        
    }
    
    override func layoutSubviews() { // Add space between cells in our main table view
        
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(5, 0, 5, 0)) //u,l,d,r
    }
    
}
