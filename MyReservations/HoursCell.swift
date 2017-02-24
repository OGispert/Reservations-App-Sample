//
//  HoursCell.swift
//  MyReservations
//
//  Created by Othmar Gispert on 2/19/17.
//  Copyright © 2017 Othmar Gispert. All rights reserved.
//

import UIKit

class HoursCell: UICollectionViewCell {
    
    @IBOutlet weak var hourTextLabel: UILabel!
    
    @IBOutlet weak var checkmarkLayer: UIImageView!
    
    //Array to fill our collection view with the optional hours to schedule
    let hoursArr = ["09:00 AM", "10:00 AM", "11:00 AM", "12:00 PM", "01:00 PM", "02:00 PM", "03:00 PM", "04:00 PM", "05:00 PM", "06:00 PM", "07:00 PM", "08:00 PM"]
    
}
