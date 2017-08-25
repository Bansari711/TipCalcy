//
//  ViewController.swift
//  TipCalcy
//
//  Created by Bansari on 8/21/17.
//  Copyright © 2017 Bansari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var noOfPeopleLabel: UILabel!
    @IBOutlet weak var amountPerPersonLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipPercentageSliderOutlet: UISlider!
    @IBOutlet weak var noOfPeopleSliderOutlet: UISlider!
    @IBOutlet weak var excellentServiceBtn: UIButton!
    @IBOutlet weak var satisfyingServiceBtn: UIButton!
    @IBOutlet weak var averageServiceBtn: UIButton!
    
    var x = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipPercentageSliderOutlet.value = Float(tipPercentageLabel.text!)!
        noOfPeopleSliderOutlet.value = Float(noOfPeopleLabel.text!)!
        
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol!
        
        tipAmountLabel.text = currencySymbol + "0.00"
        amountPerPersonLabel.text = currencySymbol + "0.00"
        totalAmountLabel.text = currencySymbol + "0.00"
        print("viewDidLoad")
        print(UserDefaults.standard.object(forKey: "test"))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("call")
        self.view.setBackground(colorOne: Colors.colorBright, view: self.view, x: x)
        x = x + 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        billTextField.becomeFirstResponder()
        
        if let lastBillAmount = SettingsHelper.getLastBillAmount() {
            billTextField.text = lastBillAmount
        }
        else{
            billTextField.text = "";
        }
        
        
    }
    
    
    
    @IBAction func calculateTipBillTextField(_ sender: Any) {
        let tipPercentage = Int(tipPercentageLabel.text!)
        SettingsHelper.setLastBillAmount(billAmount: billTextField.text!)
        
        calculateTipAmount(tipPercentage: tipPercentage!)
    }
    
    @IBAction func tipPercentageSlider(_ sender: UISlider) {
        tipPercentageLabel.text = String(Int(sender.value))
        
        excellentServiceBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
        satisfyingServiceBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
        averageServiceBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
        
        calculateTipAmount(tipPercentage: Int(sender.value))
    }
    
    @IBAction func noOfPeopleSlider(_ sender: UISlider) {
        noOfPeopleLabel.text = String(Int(sender.value))
        calculateAmountPerPerson(noOfPeople: Int(sender.value))
    }
    
    @IBAction func excellentServiceTipBtn(_ sender: Any) {
        
        setServiceTip(serviceRate: "ExcellentServiceTip")
        
        excellentServiceBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 55)
        satisfyingServiceBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
        averageServiceBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
        //bounceServiceButtons(sender: sender as! UIButton)
    }
    
    @IBAction func satisfyingServiceTipBtn(_ sender: Any) {
        
        setServiceTip(serviceRate: "SatisfactoryServiceTip")
        
        excellentServiceBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
        satisfyingServiceBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 55)
        averageServiceBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
    }
    
    @IBAction func averageServiceTipBtn(_ sender: Any) {
        setServiceTip(serviceRate: "AverageServiceTip")
        
        excellentServiceBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
        satisfyingServiceBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
        averageServiceBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 55)
        //bounceServiceButtons(sender: sender as! UIButton)
    }
    
    
    
    
    func calculateTipAmount(tipPercentage:Int?){
        let bill = Double(billTextField.text!) ?? 0
        let tip = bill * Double(tipPercentage!) / 100
        let noOfPeople = Int(noOfPeopleLabel.text!)!
        
        let formatted = NumberFormatter()
        formatted.numberStyle = .decimal
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        
        currencyFormatter.locale = NSLocale.current
        let tipAmountString = currencyFormatter.string(from: NSNumber(value: tip))
        
        tipAmountLabel.text = tipAmountString!
        tipPercentageLabel.text = String(format: "%d", tipPercentage!)
        tipPercentageSliderOutlet.value = Float(tipPercentageLabel.text!)!
        
        calculateAmountPerPerson(noOfPeople: noOfPeople)
    }
    
    func calculateAmountPerPerson(noOfPeople:Int){
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        currencyFormatter.locale = NSLocale.current
        
        let bill = Double(billTextField.text!) ?? 0
        let tip = bill * Double(tipPercentageLabel.text!)! / 100
      
        let totalAmount = bill + tip
        let amountPerPerson = totalAmount / Double(noOfPeople)
        
        
        
        amountPerPersonLabel.text = currencyFormatter.string(from: NSNumber(value: amountPerPerson))
        noOfPeopleLabel.text = String(format: "%d", noOfPeople)
        totalAmountLabel.text = currencyFormatter.string(from: NSNumber(value: totalAmount))
        
        noOfPeopleSliderOutlet.value = Float(noOfPeopleLabel.text!)!
    }
       
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setServiceTip(serviceRate:String) {
        let path = Bundle.main.path(forResource: "TipSettings", ofType: "plist")
        print(path!)
        
        let url = URL(fileURLWithPath: path!)
        print(url)
        
        let obj = NSDictionary(contentsOf: url)
        
        if let tip = obj!.value(forKey: serviceRate){
            self.tipPercentageLabel.text = tip as? String ?? ""
            self.tipPercentageSliderOutlet.value = Float(tip as? String ?? "0")!
        }
        
        calculateTipAmount(tipPercentage: Int(tipPercentageLabel.text!)!)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        UserDefaults.standard.set("123", forKey: "test")
        UserDefaults.standard.synchronize()
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        UserDefaults.standard.set("123", forKey: "test")
        UserDefaults.standard.synchronize()
    }
    
    func applicationDidEnterForeground(application: UIApplication) {
        print("DidEnter")
    }
    
    func applicationWillTerminate(application: UIApplication) {
        UserDefaults.standard.set("123", forKey: "test")
        UserDefaults.standard.synchronize()
    }
}

