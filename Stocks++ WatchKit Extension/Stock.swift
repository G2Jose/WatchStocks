//
//  Stock.swift
//  Stocks++
//
//  Created by George Jose on 2015-09-24.
//  Copyright © 2015 George Jose. All rights reserved.
//

import Foundation
class Stock{
    var symbol: String
    var change: Double = 0
    var price: Double = 0
    
    var buyPrice: Double
    var quantity: Double
    var commission: Double
    
    var gainAmountT: Double = 0
    var gainPercentT: Double = 0
    var marketValueT: Double = 0
    var costBasisT: Double = 0
    var daysGainAmountT: Double = 0
    var daysGainPercentT: Double = 0
    
    var updated: Bool = false
    
    init(symbol: String, buyPrice: Double, quantity: Double, commission: Double){
        self.symbol = symbol
        self.buyPrice = buyPrice
        self.quantity = quantity
        self.commission = commission
    }
    
    func update(change: Double, price: Double){
        self.change = change
        self.price = price
        
        self.gainAmountT = (self.price - self.buyPrice) * self.quantity - self.commission
        self.gainPercentT = self.gainAmountT * 100 / (self.buyPrice * self.quantity + self.commission)
        self.marketValueT = self.price * self.quantity
        self.costBasisT = self.buyPrice * self.quantity + self.commission
        self.daysGainAmountT = self.change * self.quantity
        print("Change: \(self.change)\tPrice: \(self.price)")
        self.daysGainPercentT = self.change / self.price * 100
        self.updated = true
    }
    
}