//
//  CalendarVC.swift
//  MyReservations
//
//  Created by Othmar Gispert on 2/20/17.
//  Copyright © 2017 Othmar Gispert. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarVC: UIViewController, FSCalendarDataSource, FSCalendarDelegate {

    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendar.dataSource = self
        calendar.delegate = self
        calendar.scope = .month //Show entire calendar
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }

}
