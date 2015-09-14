//
//  Stock.swift
//  Demo
//
//  Created by George Jose on 2015-09-12.
//  Copyright © 2015 George Jose. All rights reserved.
//

import Foundation
class Stock{
    var symbol: String
    var buyPrice: Double
    var currentPrice: Double = 0
    var costBasis: Double = 0
    var marketValue: Double = -1
    var gainAmount: Double = 0
    var gainPercent: Double = 0
    var quantity: Double = 0
    var commission: Double = 0
    var url: String = ""
    
    init(symbol: String, buyPrice: Double, quantity: Double, commission: Double){
        self.symbol = symbol
        self.buyPrice = buyPrice
        self.quantity = quantity
        self.commission = commission
        self.url = Parameters.baseURL + symbol
        print("Debug: Initializing stock\(self.symbol)")
    }
    
    
    
    
    
        
}