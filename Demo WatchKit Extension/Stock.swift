//
//  Stock.swift
//  Demo
//
//  Created by George Jose on 2015-09-12.
//  Copyright © 2015 George Jose. All rights reserved.
//

import Foundation
class Stock{
    var symbol: String = ""
    var query: String
    
    var buyPrice: Double
    var currentPrice: Double = 0
    var costBasis: Double = 0
    var marketValue: Double = -1
    
    var gainAmount: Double = 0
    var gainPercent: Double = 0
    
    var quantity: Double = 0
    var commission: Double = 0
    var daysGain: Double = 0
    var daysGainTotal: Double = 0
    var url: String = ""
    
    init(query: String, buyPrice: Double, quantity: Double, commission: Double){
        self.query = query
        self.buyPrice = buyPrice
        self.quantity = quantity
        self.commission = commission
        self.url = Parameters.baseURL + query
        if (Parameters.debug == 1){
            print("Debug: Initializing stock\(self.symbol)")
        }
    }
    
    enum JSONError: String, ErrorType {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    func update(){
        Portfolio.log("update()")
        let urlPath = self.url
        guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint");return }
        let request = NSMutableURLRequest(URL:endpoint)
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            do {
                guard let dat = data else { throw JSONError.NoData }
                guard let json = try NSJSONSerialization.JSONObjectWithData(dat, options: []) as? NSDictionary else { throw JSONError.ConversionFailed }
                
                self.currentPrice =  (json["marketValue"] as! NSString).doubleValue
                self.daysGain = (json["change"] as! NSString).doubleValue
                self.symbol = json["stockSymbol"] as! NSString as String
                self.marketValue = self.currentPrice * self.quantity
                self.costBasis = self.buyPrice * self.quantity + self.commission
                self.gainAmount = self.marketValue  - self.costBasis
                self.gainPercent = self.gainAmount / (self.costBasis) * 100

                Portfolio.log(self.symbol + " " + String(format:"%.2f", self.daysGain))
               
                self.daysGainTotal = self.daysGain * self.quantity
                print("day's change of stock \(self.symbol) = \(self.daysGain)")
                Portfolio.stocksToUpdate--
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch {
                print(error)
            }}.resume()
    }
}