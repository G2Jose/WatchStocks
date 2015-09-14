//
//  Portfolio.swift
//  Demo
//
//  Created by George Jose on 2015-09-12.
//  Copyright © 2015 George Jose. All rights reserved.
//

import Foundation

class Portfolio{
    static var stocks = [String: Stock]()
    static var costBasis: Double = 0
    static var marketValue: Double = 0
    static var gainAmount: Double = 0
    static var gainPercent: Double = 0
    static var stocksToUpdate = 0
    
    static func addStock(stock: Stock){
        stocks[stock.symbol] = stock
        stocksToUpdate++
    }
    static func clearPortfolio(){
        costBasis = 0
        marketValue = 0
        gainAmount = 0
        gainPercent = 0
        stocksToUpdate = 0
        
    }
    static func updatePortfolio(){
        clearPortfolio()
        print("Debug: Attempting to update portfolio")
        for (_, stock) in self.stocks{
            self.marketValue += stock.marketValue
            self.costBasis+=stock.costBasis
            print("-----------------------")
            print("\(stock.symbol): Cost basis: \(stock.costBasis): Market value: \(stock.marketValue)")
        }
        self.gainAmount = self.marketValue - self.costBasis
        self.gainPercent = self.gainAmount / self.costBasis * 100
        print("Portfolio updated")
        print("Gain Amount \(gainAmount)")
        print("Gain Percent \(gainPercent) %")
        
    }
    
}