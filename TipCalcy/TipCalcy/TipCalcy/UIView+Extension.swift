//
//  UIView+Extension.swift
//  TipCalcy
//
//  Created by Bansari on 8/22/17.
//  Copyright © 2017 Bansari. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor, subLayerNumber: Int) {
       
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        let gradientColors: [CGColor] = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.colors = gradientColors
        
        let gradientLocations: [Float] = [0.0, 1.0]
        gradientLayer.locations = gradientLocations as [NSNumber]
        
        layer.insertSublayer(gradientLayer, at: UInt32(subLayerNumber))
    }
    
    func setBackground(colorOne:String, view:UIView, x:Int) {
        
        if (colorOne == ""){
            view.setGradientBackground(colorOne: Colors.brightBlue, colorTwo: Colors.lightBlue, subLayerNumber: x)
        }else if (colorOne == "brightBlue"){
            view.setGradientBackground(colorOne: Colors.brightBlue, colorTwo: Colors.lightBlue, subLayerNumber: x)
        }else if (colorOne == "brightPink"){
            view.setGradientBackground(colorOne: Colors.brightPink, colorTwo: Colors.lightPink, subLayerNumber: x)
        }else if (colorOne == "brightRed"){
            view.setGradientBackground(colorOne: Colors.brightRed, colorTwo: Colors.lightRed, subLayerNumber: x)
        }else if (colorOne == "brightGreen"){
            view.setGradientBackground(colorOne: Colors.brightGreen, colorTwo: Colors.lightGreen, subLayerNumber: x)
        }
    }
}
