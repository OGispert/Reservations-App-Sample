//
//  ScheduleView.swift
//  MyReservations
//
//  Created by Othmar Gispert on 2/18/17.
//  Copyright © 2017 Othmar Gispert. All rights reserved.
//

import UIKit
import FSCalendar

class ScheduleView: UIViewController, FSCalendarDataSource, FSCalendarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var partySizeButton: UIButton!
    @IBOutlet weak var partySizePicker: UIPickerView!
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var massageTitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var theHours = HoursCell()
    
    var itemToEdit: Item?
    
    var mainTitle: String?
    var massageImage: String?
    var massageDesc: String?
    var massageDuration: String?
    var massagePrice: String?
    
    var dateString: String?
    var timeString: String?
    
    private let reuseIdentifier = "hourCell"
    
    //Give format to the date
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM dd, yyyy"
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        calendar.dataSource = self
        calendar.delegate = self
        calendar.scope = .week
        
        scrollView.delegate = self
        
        partySizePicker.dataSource = self
        partySizePicker.delegate = self
        
        //Fill every label with the information from JSON file
        if mainTitle != nil {
            massageTitle.text = mainTitle
            descriptionLabel.text = massageDesc
            durationLabel.text = massageDuration
            priceLabel.text = massagePrice
            
            if massageImage != "" {
                thumbImage.image = UIImage(named: massageImage!)
            } else {
                thumbImage.image = UIImage(named: "noImage")
            }
            
        } else {
          massageTitle.text = "Hot Stone Massage" //This is temporal, just to avoid empty labels
        }
        
        if itemToEdit != nil { //This is called when editing previous schedule
            loadItemData()
        }
        
        collectionView.allowsMultipleSelection = false //Avoid multiple selection in CollectionView
    }
    
    //MARK: FSCalendar Delegate
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
     
        dateString = "\(self.formatter.string(from: date))"
    }
    
    //MARK: UICollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return theHours.hoursArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HoursCell
        
        cell.hourTextLabel.text = theHours.hoursArr[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        reserveButton.isEnabled = true
        reserveButton.isOpaque = false
    
        let indexPath = collectionView.indexPathsForSelectedItems?.first
        if let cell = collectionView.cellForItem(at: indexPath!) {
            let aCell = cell as! HoursCell
            aCell.checkmarkLayer.isHidden = false
            let timeLabel = aCell.hourTextLabel.text
            timeString = timeLabel!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            let aCell = cell as! HoursCell
            aCell.checkmarkLayer.isHidden = true
        }
        
    }
    
    //MARK: UIPickerView Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return partySize.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return partySize[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        partySizeButton.setTitle(partySize[row], for: UIControlState.normal)
        partySizePicker.isHidden = true
        reserveButton.isHidden = false
        collectionView.isHidden = false
        calendar.isHidden = false
        
    }
    
    @IBAction func partySizeButtonPressed(_ sender: UIButton) { //Button to update party size
        
        partySizePicker.isHidden = false
        reserveButton.isHidden = true
        collectionView.isHidden = true
        calendar.isHidden = true
    }

    @IBAction func cancelButton(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reserveButtonPressed(_ sender: UIButton) { //Button to save and schedule
        
        //Add everything to store
        var item: Item!
        
        let picture = Image(context: context)
        
        picture.image = thumbImage.image
        
        if itemToEdit == nil {
            
            item = Item(context: context)
        
        } else {
            
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = massageTitle.text {
            item.massage = title
        }
        
        if let description = descriptionLabel.text {
            item.massageDesc = description
        }
        
        if let party = partySizeButton.titleLabel?.text {
            item.partySize = party
        }
        
        if let theDate = dateString {
            item.date = theDate
        }
        
        if let theTime = timeString {
            item.time = theTime
        }
        
        ad.saveContext() //Save the data
        
        dismiss(animated: true, completion: nil)
    }
    
    func loadItemData() { //Loads stored data again
        
        if let item = itemToEdit {
            massageTitle.text = item.massage
            descriptionLabel.text = item.massageDesc
            partySizeButton.titleLabel?.text = item.partySize
            dateString = item.date
            timeString = item.time
            
            thumbImage.image = item.toImage?.image as? UIImage
        }
    }
    
}
