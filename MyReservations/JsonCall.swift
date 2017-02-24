//
//  JsonCall.swift
//  MyReservations
//
//  Created by Othmar Gispert on 2/18/17.
//  Copyright © 2017 Othmar Gispert. All rights reserved.
//

import Foundation

class JsonCall {
    
    var paqsArr = [String]()
    var paqImage = [String]()
    var paqDescription = [String]()
    var paqDuration = [String]()
    var paqPrice = [String]()
    
    
    func downloadList() {
        
        let myURL = URL(string: URL_PATH) //Call URL from Constants
        
        do {
            
            let myData = try Data(contentsOf: myURL!)
            
            let myJson = try JSONSerialization.jsonObject(with: myData, options: .allowFragments) as! [String : AnyObject]
            
            if let paqList = myJson["paqsList"] { //Retreive JSON main string
                
                for i in 0..<paqList.count {
                    
                    var thePaq = paqList[i] as! [String : AnyObject]
                    
                    paqsArr.append(thePaq["procedure"] as! String)
                    paqImage.append(thePaq["image"] as! String)
                    paqDescription.append(thePaq["description"] as! String)
                    paqDuration.append(thePaq["duration"] as! String)
                    paqPrice.append(thePaq["price"] as! String)
                    
                }
            }
            
        } catch {
            
            print("There was an error")
        }
    }
}
