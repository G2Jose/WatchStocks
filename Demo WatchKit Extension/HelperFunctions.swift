//
//  HelperFunctions.swift
//  Demo
//
//  Created by George Jose on 2015-09-16.
//  Copyright © 2015 George Jose. All rights reserved.
//

import Foundation
import UIKit

class HF{
    static func string(value: Double, format: String) -> String{
        var prefix: String  = ""
        var preprefix: String = ""
        var postfix: String = ""
        var valueString = String(format: "%.2f", value)
        
        switch format{
            case "$":
                prefix = "$"
                postfix = ""
            case "%":
                prefix = ""
                postfix = "%"
            default:
                prefix = ""
                postfix = ""
        }
        
        switch value{
        case _ where value < 0:
            preprefix = "-"
            valueString = valueString.stringByReplacingOccurrencesOfString("-", withString: "")
        case _ where value > 0:
            preprefix
                = "+"
        default:
            preprefix = ""
        }
        
        return (preprefix + prefix + valueString + postfix)
    }
    
    static func getColor(value: Double)  -> UIColor{
        switch value{
        case _ where value < 0:
            return UIColor.redColor()
        default:
            return UIColor.greenColor()
        }
    }
}