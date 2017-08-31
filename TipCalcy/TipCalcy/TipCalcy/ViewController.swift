//
//  ViewController.swift
//  TipCalcy
//
//  Created by Bansari on 8/21/17.
//  Copyright © 2017 Bansari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    

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
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipPercentageSliderOutlet.value = Float(tipPercentageLabel.text!)!
        noOfPeopleSliderOutlet.value = Float(noOfPeopleLabel.text!)!
        
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol!
        
        tipAmountLabel.text = currencySymbol + "0.00"
        amountPerPersonLabel.text = currencySymbol + "0.00"
        totalAmountLabel.text = currencySymbol + "0.00"
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        billTextField.text = "";
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
        let url = URL(fileURLWithPath: path!)
        let obj = NSDictionary(contentsOf: url)
        
        if let tip = obj!.value(forKey: serviceRate){
            self.tipPercentageLabel.text = tip as? String ?? ""
            self.tipPercentageSliderOutlet.value = Float(tip as? String ?? "0")!
        }
        
        calculateTipAmount(tipPercentage: Int(tipPercentageLabel.text!)!)
    }
    
    @IBAction func savePdfBtn(_ sender: Any) {
        
        var checkNumber: Int = UserDefaults.standard.object(forKey: "check_number") as! Int
        print(checkNumber)
        if checkNumber != 1000 {
            checkNumber = checkNumber + 1
            UserDefaults.standard.set(checkNumber, forKey: "check_number")
        }else{
            UserDefaults.standard.set(1000, forKey: "check_number")
            checkNumber = 1000
        }
        
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = "\(path)/Check\(checkNumber).pdf"
        print(path)
        print(filePath)
        
        generatePDF(filePath: filePath, checkNumber: checkNumber)
        
               

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PdfViewSegue") {
            var checkNumber: Int = UserDefaults.standard.object(forKey: "check_number") as! Int
            print(checkNumber)
            if checkNumber != 1000 {
                checkNumber = checkNumber + 1
                UserDefaults.standard.set(checkNumber, forKey: "check_number")
            }else{
                UserDefaults.standard.set(1000, forKey: "check_number")
                checkNumber = 1000
            }
            
            
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let filePath = "\(path)/Check\(checkNumber).pdf"
            print(path)
            print(filePath)
            
            generatePDF(filePath: filePath, checkNumber: checkNumber)
            
            //get a reference to the destination view controller
            let destinationVC:PdfViewController = segue.destination as! PdfViewController
            //set properties on the destination view controller
            destinationVC.pdfFileName = "Check\(checkNumber)"
            //etc...
        }

    }
    
    func generatePDF(filePath:String, checkNumber:Int) {
        UIGraphicsBeginPDFContextToFile(filePath, CGRect.zero, nil)
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 850, height: 1200), nil)
        
        PdfSettings.drawImage()
        PdfSettings.drawText(billAmount: billTextField.text!, tipPercentage: tipPercentageLabel.text!, tipAmount: tipAmountLabel.text!, noOfPeople: noOfPeopleLabel.text!, paymentPerPerson: amountPerPersonLabel.text!, totalAmount: totalAmountLabel.text!, checkNumber: checkNumber)
        
        UIGraphicsEndPDFContext()
    }
    
    
    
}
