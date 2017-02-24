//
//  RoundCorners.swift
//  MyReservations
//
//  Created by Othmar Gispert on 2/18/17.
//  Copyright © 2017 Othmar Gispert. All rights reserved.
//

import UIKit


//Adds options to file inspector, in this case we want to give a corner radius to our buttons
@IBDesignable

class RoundCorners: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
    
}
