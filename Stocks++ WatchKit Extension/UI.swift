//
//  UI.swift
//  Stocks++
//
//  Created by George Jose on 2015-09-24.
//  Copyright © 2015 George Jose. All rights reserved.
//

import Foundation
import WatchKit
class UI{
    static func setText(label: WKInterfaceLabel, amount: Double, format: String){
        
        var prefix = ""
        var preprefix = ""
        var postfix = ""
        var color: UIColor
        let absAmount: Double
        
        switch(amount){
        case _ where amount >= 0:
            color = UIColor.greenColor()
            preprefix = "+"
            absAmount = amount
        default:
            color = UIColor.redColor()
            preprefix = "-"
            absAmount = amount * -1
        }
        
        switch(format){
        case _ where (format == "%"):
            postfix = "%"
            prefix = ""
        case _ where (format == "abs"):
            postfix = ""
            prefix = "$"
            preprefix = ""
            color = UIColor.whiteColor()
        case _ where (format == "$"):
            postfix = ""
            prefix = "$"
        default:
            prefix = ""
            postfix = ""
        }
        
        
        label.setText(preprefix + prefix + String(format:"%.2f", absAmount) + postfix)
        label.setTextColor(color)
    }
    
    static func clear(label: WKInterfaceLabel){
        label.setTextColor(UIColor.whiteColor())
        label.setText("Loading...")
    }
}