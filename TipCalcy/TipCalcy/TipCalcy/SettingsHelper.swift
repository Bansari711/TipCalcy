//
//  SettingsHelper.swift
//  TipCalcy
//
//  Created by Bansari on 8/24/17.
//  Copyright © 2017 Bansari. All rights reserved.
//

import Foundation
import UIKit

class SettingsHelper {
    // Use a struct with static fields as to not the pollute the global namespace
    struct Constants {
        
        static let lastBillAmountKey = "last_bill_amount"
        static let lastBillTimestampKey = "last_bill_timestamp"
        
        // Persist bill amount across app restarts for 10 minutes
        static let billAmountTimeToLive = TimeInterval(10 * 60)
        
        static let defaults = UserDefaults.standard
    }
    
    class func setLastBillAmount(billAmount: String) {
        Constants.defaults.set(billAmount, forKey: Constants.lastBillAmountKey)
        Constants.defaults.set(NSDate(), forKey: Constants.lastBillTimestampKey)
        
        Constants.defaults.synchronize()
    }
    
    class func getLastBillAmount() -> String? {
        let now = NSDate()
        let lastBillTimestamp = Constants.defaults.object(forKey: Constants.lastBillTimestampKey) as! NSDate?
        
        let isBillAmountExpired = lastBillTimestamp == nil || now.timeIntervalSince(lastBillTimestamp! as Date) > Constants.billAmountTimeToLive
        
        if isBillAmountExpired {
            return nil
        } else {
            return Constants.defaults.object(forKey: Constants.lastBillAmountKey) as! String?
        }
    }
}
