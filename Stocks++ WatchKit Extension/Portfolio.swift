//
//  Portfolio.swift
//  Stocks++
//
//  Created by George Jose on 2015-09-24.
//  Copyright © 2015 George Jose. All rights reserved.
//

import Foundation
class Portfolio{
    static var marketValue: Double = 0
    static var costBasis: Double = 0
    static var daysGainAmount: Double = 0
    static var daysGainPercent: Double = 0
    static var gainAmount: Double = 0
    static var gainPercent: Double = 0
    static var done: Bool = false
    
    static var stocks = [String: Stock]()
    
    static var queryString: String = ""
    static var baseUrl: String = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quote%20where%20symbol%20in%20("
    static var url = ""
    static var tailUrl = ")&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
    
    static func clearPortfolio(){
        marketValue = 0
        costBasis = 0
        daysGainAmount = 0
        daysGainPercent = 0
        gainAmount = 0
        gainPercent = 0
        done = false
        
        stocks = [String:Stock]()
        url = ""
    }
    static func initialize(){
        clearPortfolio()
        for (symbol, details) in Parameters.myStocks{
            self.stocks[symbol] = Stock(symbol: symbol, buyPrice: details["buyPrice"]!, quantity: details["quantity"]!, commission: details["commission"]!)
        }
        self.makeURL()
    }
    
    static func makeURL(){
        self.url = self.baseUrl
        for (symbol, _) in self.stocks{
            url = url + "%22" + symbol + "%22%2C"
        }
        url = url.substringWithRange(Range<String.Index>(start: url.startIndex, end: url.endIndex.advancedBy(-3)))
        url = url + self.tailUrl
    }
    
    static func printContents(){
        print("Added Stocks: ")
        for (symbol, stock) in self.stocks{
            print("\(symbol):\tBuy price: \(stock.buyPrice)")
            print("\t\tQuantity: \(stock.quantity)")
            print("\t\tCommission: \(stock.commission)")
            print("\t\tPrice: \(stock.price)")
        }
    }
    
    enum JSONError: String, ErrorType {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    
    static func updatePortfolio(){
        guard let endpoint = NSURL(string: self.url) else { print("Error creating endpoint");return }
        let request = NSMutableURLRequest(URL:endpoint)
        
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            do {
                guard let dat = data else { throw JSONError.NoData }
                guard let json = try NSJSONSerialization.JSONObjectWithData(dat, options: []) as? NSDictionary else { throw JSONError.ConversionFailed }
                
                if(self.stocks.count > 1){
                    let responses = ((json["query"] as! NSDictionary)["results"] as! NSDictionary)["quote"] as! NSArray
                    for (item) in responses{
                        print(item["symbol"])
                        
                        self.stocks[item["symbol"] as! String]?.update((item["Change"] as! NSString).doubleValue, price: (item["LastTradePriceOnly"] as! NSString).doubleValue)
                    }
                    processStocks()
                
                }else{
                    let response = ((json["query"] as! NSDictionary)["results"] as! NSDictionary)["quote"] as! NSDictionary
                        self.stocks[response["symbol"] as! String]?.update((response["Change"] as! NSString).doubleValue, price: (response["LastTradePriceOnly"] as! NSString).doubleValue)
                    processStocks()
                }
                
                
                
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch {
                print(error)
            }}.resume()
        
    }
    
    static func processStocks(){
        for(_, stock) in self.stocks{
            Portfolio.marketValue += stock.marketValueT
            Portfolio.gainAmount += stock.gainAmountT
            Portfolio.daysGainAmount += stock.daysGainAmountT
            Portfolio.costBasis += stock.costBasisT
        }
        Portfolio.gainPercent = Portfolio.gainAmount / Portfolio.costBasis * 100
        Portfolio.daysGainPercent = Portfolio.daysGainAmount / Portfolio.costBasis * 100
        printContents()
        self.done = true
    }
}