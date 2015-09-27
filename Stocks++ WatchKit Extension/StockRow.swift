//
//  StockRow.swift
//  Stocks++
//
//  Created by George Jose on 2015-09-26.
//  Copyright © 2015 George Jose. All rights reserved.
//

import Foundation
import WatchKit

class StockRow: NSObject{
    @IBOutlet var symbolOutlet: WKInterfaceLabel!
    
    @IBOutlet var priceOutlet: WKInterfaceLabel!
    @IBOutlet var daysChangePercentOutlet: WKInterfaceLabel!
    @IBOutlet var daysChangeAmountOutlet: WKInterfaceLabel!
}