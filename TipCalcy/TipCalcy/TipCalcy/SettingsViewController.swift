//
//  SettingsViewController.swift
//  TipCalcy
//
//  Created by Bansari on 8/21/17.
//  Copyright © 2017 Bansari. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {
    
    @IBOutlet weak var pinkBackgroundBtn: UIButton!
    @IBOutlet weak var greenBackgroundBtn: UIButton!
    @IBOutlet weak var redBackgroundBtn: UIButton!
    @IBOutlet weak var blueBackgroundBtn: UIButton!
    @IBOutlet var excellentServiceTipLabel: UILabel!
    
    @IBOutlet weak var satisfyingServiceTipLabel: UILabel!
    @IBOutlet weak var averageServiceTipLabel: UILabel!
    @IBOutlet weak var excellentServiceTipSliderOutlet: UISlider!
    @IBOutlet weak var satisfyingServiceTipSliderOutlet: UISlider!
    @IBOutlet weak var averageServiceTipSliderOutlet: UISlider!
    
    var x = 0
    var colorBright: String = Colors.colorBright
    
    let excellentServiceTip = 25
    let satisfactoryServiceTip = 20
    let averageServiceTip = 18
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.setBackground(colorOne: Colors.colorBright, view: self.view, x: x)
        x = x + 1
        
        setButtonGradientBackground()
        setSliderValueForAllServices()
    }
    
    @IBAction func excellentServiceTipSliderAction(_ sender: UISlider) {
        excellentServiceTipLabel.text = String(Int(sender.value))
    }
    
    @IBAction func satisfyingServiceTipSliderAction(_ sender: UISlider) {
        satisfyingServiceTipLabel.text = String(Int(sender.value))
    }
    
    @IBAction func averageServiceTipSliderAction(_ sender: UISlider) {
        averageServiceTipLabel.text = String(Int(sender.value))
    }
    
    
    @IBAction func pinkBackgroundBtn(_ sender: Any) {
        self.view.setGradientBackground(colorOne: Colors.brightPink, colorTwo: Colors.lightPink, subLayerNumber: x)
        colorBright = "brightPink"
        x = x + 1
    }
    
    @IBAction func greenBackgroundBtn(_ sender: Any) {
        self.view.setGradientBackground(colorOne: Colors.brightGreen, colorTwo: Colors.lightGreen, subLayerNumber: x)
        colorBright = "brightGreen"
        x = x + 1
    }
    
    @IBAction func redBackgroundBtn(_ sender: Any) {
        self.view.setGradientBackground(colorOne: Colors.brightRed, colorTwo: Colors.lightRed, subLayerNumber: x)
        colorBright = "brightRed"
        x = x + 1
    }
    
    @IBAction func blueBackgroundBtn(_ sender: Any) {
        self.view.setGradientBackground(colorOne: Colors.brightBlue, colorTwo: Colors.lightBlue, subLayerNumber: x)
        colorBright = "brightBlue"
        x = x + 1
    }
    
    @IBAction func saveTipSettings(_ sender: Any) {
        saveTipSettings()
    }
    
    func saveTipSettings() {
        let path = Bundle.main.path(forResource: "TipSettings", ofType: "plist")
        let url = URL(fileURLWithPath: path!)
        
        let excellentServiceTip = String(Int(excellentServiceTipSliderOutlet.value))
        let dict = NSMutableDictionary()
        dict.setValue(excellentServiceTip, forKey: "ExcellentServiceTip")
        dict.write(to: url, atomically: true)
        
        let satisfactoryServiceTip = String(Int(satisfyingServiceTipSliderOutlet.value))
        dict.setValue(satisfactoryServiceTip, forKey: "SatisfactoryServiceTip")
        dict.write(to: url, atomically: true)
        
        let averageServiceTip = String(Int(averageServiceTipSliderOutlet.value))
        dict.setValue(averageServiceTip, forKey: "AverageServiceTip")
        dict.write(to: url, atomically: true)
        
        dict.setValue(Colors.colorBright, forKey: "colorBright")
        dict.write(to: url, atomically: true)
    }
    
    @IBAction func resetTipSettings(_ sender: Any) {
        
        excellentServiceTipLabel.text = String(format: "%d", excellentServiceTip)
        satisfyingServiceTipLabel.text = String(format: "%d", satisfactoryServiceTip)
        averageServiceTipLabel.text = String(format: "%d", averageServiceTip)

        excellentServiceTipSliderOutlet.value = Float(excellentServiceTip)
        satisfyingServiceTipSliderOutlet.value = Float(satisfactoryServiceTip)
        averageServiceTipSliderOutlet.value = Float(averageServiceTip)
        
        self.view.setGradientBackground(colorOne: Colors.brightBlue, colorTwo: Colors.lightBlue, subLayerNumber: x)
        x = x + 1
        
        colorBright = "brightBlue"
        Colors.colorBright = colorBright
        
        saveTipSettings()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if (parent == nil){
            Colors.colorBright = colorBright
        }
    }
    
    func setButtonGradientBackground() {
        pinkBackgroundBtn.layer.cornerRadius = pinkBackgroundBtn.frame.size.height / 2
        pinkBackgroundBtn.layer.masksToBounds = true
        pinkBackgroundBtn.setGradientBackground(colorOne: Colors.brightPink, colorTwo: Colors.lightPink, subLayerNumber: 0)
        
        greenBackgroundBtn.layer.cornerRadius = greenBackgroundBtn.frame.size.height / 2
        greenBackgroundBtn.layer.masksToBounds = true
        greenBackgroundBtn.setGradientBackground(colorOne: Colors.brightGreen, colorTwo: Colors.lightGreen, subLayerNumber: 0)
        
        redBackgroundBtn.layer.cornerRadius = redBackgroundBtn.frame.size.height / 2
        redBackgroundBtn.layer.masksToBounds = true
        redBackgroundBtn.setGradientBackground(colorOne: Colors.brightRed, colorTwo: Colors.lightRed, subLayerNumber: 0)
        
        blueBackgroundBtn.layer.cornerRadius = blueBackgroundBtn.frame.size.height / 2
        blueBackgroundBtn.layer.masksToBounds = true
        blueBackgroundBtn.setGradientBackground(colorOne: Colors.brightBlue, colorTwo: Colors.lightBlue, subLayerNumber: 0)
    }
    
    func setSliderValueForAllServices() {
       
        excellentServiceTipSliderOutlet.value = 25
        satisfyingServiceTipSliderOutlet.value = 20
        averageServiceTipSliderOutlet.value = 18
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
