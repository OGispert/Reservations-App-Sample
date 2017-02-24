//
//  PaqView.swift
//  MyReservations
//
//  Created by Othmar Gispert on 2/18/17.
//  Copyright © 2017 Othmar Gispert. All rights reserved.
//

import UIKit

class PaqView: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reserveButton: RoundCorners!
    
    let myJsonCall = JsonCall()
    var massageTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        startDownload()
        
        scrollBackgroundImages() //Calls function to scroll background images
        
    }
    
    func scrollBackgroundImages() {
        //Create de container
        self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height-64)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        //Create the views with images
        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgOne.image = UIImage(named: "Paq1")
        let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgTwo.image = UIImage(named: "Paq2")
        let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgThree.image = UIImage(named: "Paq3")
        
        self.scrollView.addSubview(imgOne)
        self.scrollView.addSubview(imgTwo)
        self.scrollView.addSubview(imgThree)
        
        //Animate the views
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * 3, height:self.scrollView.frame.height)
        
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
    }
    
    //MARK: UIScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        
        // Change the button accordingly
        if Int(currentPage) == 0{
            reserveButton.isEnabled = false
            
        }else if Int(currentPage) == 1{
            reserveButton.isEnabled = true
            
        }else{
            reserveButton.isEnabled = false
        }
    }
    
    func startDownload() { //Retreive the data from JSON file
        
        myJsonCall.downloadList()
        
        tableView.reloadData()
    }
    
    //MARK: UITableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myJsonCall.paqsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "paqCell", for: indexPath)
        
        
        cell.textLabel?.text = myJsonCall.paqsArr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //Prepare for segue
        if  segue.identifier == "newMassage",
            let destination = segue.destination as? ScheduleView,
            let massageIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.mainTitle = myJsonCall.paqsArr[massageIndex]
            destination.massageDesc = myJsonCall.paqDescription[massageIndex]
            destination.massageDuration = myJsonCall.paqDuration[massageIndex]
            destination.massagePrice = myJsonCall.paqPrice[massageIndex]
            destination.massageImage = myJsonCall.paqImage[massageIndex]
        }
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
