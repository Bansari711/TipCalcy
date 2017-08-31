//
//  PdfSettings.swift
//  TipCalcy
//
//  Created by Bansari on 8/27/17.
//  Copyright © 2017 Bansari. All rights reserved.
//

import Foundation
import UIKit

class PdfSettings {
    
    class func drawImage() {
        let imageRect = CGRect(x: 125, y: 125, width: 600, height: 850)
        let image: UIImage = UIImage(named: "BillPdfBorder.png")!
        image.draw(in: imageRect)
    }

    class func drawText(billAmount: String, tipPercentage: String, tipAmount: String, noOfPeople: String, paymentPerPerson: String, totalAmount: String, checkNumber: Int) {
        
        let fontTitle = UIFont(name: "Helvetica", size: 45)
        let textRectBillTitle = CGRect(x: 290, y: 160, width: 600, height: 50)
        let billTitle = "Restuarant Bill"
        let textFontAttributesTitle: [String: AnyObject] = [ NSFontAttributeName: fontTitle! ]
        billTitle.draw(in: textRectBillTitle, withAttributes: textFontAttributesTitle)
        
        let fontCheckNumber = UIFont(name: "Helvetica", size: 30)
        let textRectCheckNumber = CGRect(x: 310, y: 210, width: 600, height: 50)
        let checkNumber = "check No.: \(checkNumber)"
        let textFontAttributesCheckNumber: [String: AnyObject] = [ NSFontAttributeName: fontCheckNumber! ]
        checkNumber.draw(in: textRectCheckNumber, withAttributes: textFontAttributesCheckNumber)
        
        let fontDashLine = UIFont(name: "Helvetica", size: 35)
        let textRectDashLinesTop = CGRect(x: 150, y: 260, width: 550, height: 50)
        let dashLinesTop = "---------------------------------------------------"
        let textFontAttributesDashLines: [String: AnyObject] = [ NSFontAttributeName: fontDashLine! ]
        dashLinesTop.draw(in: textRectDashLinesTop, withAttributes: textFontAttributesDashLines)
      
        let textRectDashLinesBottom = CGRect(x: 150, y: 550, width: 550, height: 50)
        let dashLinesBottom = "---------------------------------------------------"
        dashLinesBottom.draw(in: textRectDashLinesBottom, withAttributes: textFontAttributesDashLines)
        
        let fontDetails = UIFont(name: "Helvetica", size: 35)
        let textRectBillDetailsTitle = CGRect(x: 150, y: 310, width: 350, height: 400)
        let billDetailsTitle = "Bill Amount:\nTip:\n\nNo Of People:\nPayment Per Person:"
        let textFontAttributesDetails: [String: AnyObject] = [ NSFontAttributeName: fontDetails! ]
        billDetailsTitle.draw(in: textRectBillDetailsTitle, withAttributes: textFontAttributesDetails)
       
        let textRectBillDetailsValue = CGRect(x: 550, y: 310, width: 200, height: 400)
        let billDetailsValue = "\(billAmount)\n\(tipPercentage)%\n\(tipAmount)\n\(noOfPeople)\n\(paymentPerPerson)"
        billDetailsValue.draw(in: textRectBillDetailsValue, withAttributes: textFontAttributesDetails)

        let fontTitleBillTotal = UIFont(name: "Helvetica", size: 40)
        let textFontAttributesBillTotal: [String: AnyObject] = [ NSFontAttributeName: fontTitleBillTotal! ]
        let textRectBillTotal = CGRect(x: 150, y: 600, width: 350, height: 100)
        let billTotal = "Total Amount:"
        billTotal.draw(in: textRectBillTotal, withAttributes: textFontAttributesBillTotal)
        
        let textRectBillTotalValue = CGRect(x: 550, y: 600, width: 200, height: 100)
        let billTotalValue = "\(totalAmount)"
        billTotalValue.draw(in: textRectBillTotalValue, withAttributes: textFontAttributesBillTotal)

        let fontThankyou = UIFont(name: "Helvetica", size: 30)
        let textRectThankYou = CGRect(x: 320, y: 750, width: 600, height: 50)
        let thankYouNote = "THANK YOU!!!"
        let textFontAttributesthankYouNote: [String: AnyObject] = [ NSFontAttributeName: fontThankyou! ]
        thankYouNote.draw(in: textRectThankYou, withAttributes: textFontAttributesthankYouNote)
    }

    class func drawBackground() {
    
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 10, y: 10, width: 800, height: 1000)
        context?.setFillColor(UIColor.blue.cgColor)
        context?.fill(rect)
    
    }
}
