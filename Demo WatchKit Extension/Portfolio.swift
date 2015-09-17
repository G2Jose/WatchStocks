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
    static var daysGain: Double = 0
    
    static var stocksToUpdate: Int = 0

    static var log: String = "Starting Log... \n"
    static var jsonLog: String = "JSON Log... \n"
    
    static func log(logString: String){
        print(logString)
        self.log += logString + "\n"
    }
    static func jsonLog(logString: String){
        self.jsonLog += logString + "\n"
    }
    
    static func addStock(stock: Stock){
        Portfolio.log("addStock(\(stock.query))")
        stocks[stock.query] = stock
        stocksToUpdate++
    }
    
    static func clearPortfolio(){
        
        Portfolio.log("clearPortfolio()")
        stocks = [String: Stock]()
        costBasis = 0
        marketValue = 0
        gainAmount = 0
        gainPercent = 0
        daysGain = 0
        stocksToUpdate = 0
        log = ""
        jsonLog = ""

    }
    
    static func updateStocks(){
        Portfolio.log("starting updateStocks()")
        for (_, stock) in self.stocks{
            stock.update()
        }
    }
    
    static func updatePortfolio(){
        Portfolio.log("\nUpdating Portfolio\n")
        for (_, stock) in self.stocks{
            self.marketValue += stock.marketValue
            self.costBasis+=stock.costBasis
            self.daysGain+=stock.daysGainTotal
            
            Portfolio.log("----Stock: \(stock.symbol)----")
            Portfolio.log("Mkt val: \(stock.marketValue)")
            Portfolio.log("Cost Bs: \(stock.costBasis)")
            Portfolio.log("Days Gn: \(stock.daysGain)")
        }
        self.gainAmount = self.marketValue - self.costBasis
        self.gainPercent = self.gainAmount / self.costBasis * 100
        Portfolio.log("----Portfolio updated----")
        Portfolio.log("Total Gain $: \(self.gainAmount)")
        Portfolio.log("Gain %: \(self.gainPercent)")
        Portfolio.log("Day's gain: \(self.daysGain)")
        
    }
    
}