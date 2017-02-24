//
//  CellDesign.swift
//  MyReservations
//
//  Created by Othmar Gispert on 2/18/17.
//  Copyright © 2017 Othmar Gispert. All rights reserved.
//

import UIKit

//This extension was created to add custom appearance to our cells

private var cellKey = false

extension UIView {
    
    @IBInspectable var cellDesign: Bool {
        
        get {
            
            return cellKey
        }
        
        set {
            
            cellKey = newValue
            
            if cellKey {
                
                self.layer.masksToBounds = false
                self.layer.borderWidth = 4.0
                self.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 157/255).cgColor
                
            } else {
                
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
            
        }
        
    }
    
}
