//
//  InterfaceController.swift
//  Demo WatchKit Extension
//
//  Created by George Jose on 2015-09-12.
//  Copyright © 2015 George Jose. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var gainPercentOutlet: WKInterfaceLabel!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    
    
    var shouldUpdate:Double = 0.0{
        didSet{
            print("Finished updating portfolio")
            gainPercentOutlet.setText(String(format: "%.3f", Portfolio.gainPercent) + "%")
        }
    }
    
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        initializeStocks()
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func buyStock(symbol: String, buyPrice: Double, quantity: Double, commission: Double){
        Portfolio.addStock(Stock(symbol:symbol, buyPrice: buyPrice, quantity: quantity, commission: commission))
    }
    
    enum JSONError: String, ErrorType {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    func update(){
        for (_, stock) in Portfolio.stocks{
            let urlPath = stock.url
            guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint");return }
            let request = NSMutableURLRequest(URL:endpoint)
            print("Attempting to update stock\(stock.symbol) with url \(stock.url)")
            NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
                do {
                    guard let dat = data else { throw JSONError.NoData }
                    guard let json = try NSJSONSerialization.JSONObjectWithData(dat, options: []) as? NSDictionary else { throw JSONError.ConversionFailed }
                    print("Debug: Updating stock: \(stock.symbol)")
                    print(json)
                    let marketValue = json["marketValue"]
                    stock.currentPrice = (marketValue as! NSString).doubleValue
                    stock.marketValue = stock.currentPrice * stock.quantity
                    stock.costBasis = stock.buyPrice * stock.quantity + stock.commission
                    stock.gainAmount = stock.marketValue  - stock.costBasis
                    stock.gainPercent = stock.gainAmount / (stock.costBasis) * 100
                    Portfolio.stocksToUpdate--
                    if(Portfolio.stocksToUpdate == 0){
                        Portfolio.updatePortfolio()
                        self.gainPercentOutlet.setText((String(format: "%.2f",Portfolio.gainPercent))+"%")
                        print("Updating Portfolio")
                    }
                } catch let error as JSONError {
                    print(error.rawValue)
                } catch {
                    print(error)
                }
                }.resume()
        }
    }

    
    
    
    func initializeStocks(){
        for (stockName, stock) in Parameters.myStocks{
            buyStock(stockName, buyPrice: stock["buyPrice"]!, quantity: stock["quantity"]!, commission: stock["commission"]!)
        }
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//            for (_, stock) in Portfolio.stocks{
//                stock.update()
//            }
//            Portfolio.updatePortfolio()
//            dispatch_async(dispatch_get_main_queue(), {
//                print("Finished updating portfolio")
//                self.gainPercentOutlet.setText(String(format: "%.3f", Portfolio.gainPercent) + "%")
//            });
//        });
        update()
    }
}
