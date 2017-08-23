//
//  LaunchScreenViewController.swift
//  TipCalcy
//
//  Created by Bansari on 8/22/17.
//  Copyright © 2017 Bansari. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let colorTop = UIColor(red: 15.0 / 255.0, green: 118.0 / 255.0, blue: 128.0 / 255.0, alpha: 1.0)
        let colorBottom = UIColor(red: 84.0 / 255.0, green: 187.0 / 255.0, blue: 187.0 / 255.0, alpha: 1.0)
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        let gradientColors: [CGColor] = [colorTop.cgColor, colorBottom.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
