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
    @IBOutlet var gainAmountOutlet: WKInterfaceLabel!
    
    @IBAction func refreshButtonAction() {
        print("---------REFRESH BUTTON PRESSED---------")
        Portfolio.clearPortfolio()
        addStocks()
        update()
    }
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    
    var shouldUpdate:Double = 0.0{
        didSet{
            print("Finished updating portfolio")
            gainPercentOutlet.setText(String(format: "%.3f", Portfolio.gainPercent) + "%")
        }
    }
    
    override func willActivate() {
        super.willActivate()
        addStocks()
        update()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func initializeStocks(symbol: String, buyPrice: Double, quantity: Double, commission: Double){
        Portfolio.addStock(Stock(symbol:symbol, buyPrice: buyPrice, quantity: quantity, commission: commission))
    }
    
    enum JSONError: String, ErrorType {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    func update(){
        print("Running update()")
        self.gainPercentOutlet.setTextColor(UIColor.whiteColor())
        self.gainAmountOutlet.setTextColor(UIColor.whiteColor())
        for (_, stock) in Portfolio.stocks{
            let urlPath = stock.url
            guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint");return }
            let request = NSMutableURLRequest(URL:endpoint)
            self.gainPercentOutlet.setText("Updating...")
            self.gainAmountOutlet.setText("Updating...")
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
                        dispatch_async(dispatch_get_main_queue()){
                            print("Updating Portfolio")
                            Portfolio.updatePortfolio()
                            var color: UIColor
                            var prefix: String = ""
                            if(Portfolio.gainAmount>=0){
                                color = UIColor.greenColor()
                                prefix = "+"
                            }else{
                                color = UIColor.redColor()
                                prefix = "-"
                            }
                            self.gainPercentOutlet.setText(prefix+(String(format: "%.2f",Portfolio.gainPercent))+"%")
                            self.gainAmountOutlet.setText(prefix+"$"+(String(format: "%.2f",Portfolio.gainAmount)))
                            self.gainPercentOutlet.setTextColor(color)
                            self.gainAmountOutlet.setTextColor(color)
                        }
                    }
                } catch let error as JSONError {
                    print(error.rawValue)
                } catch {
                    print(error)
                }
                }.resume()
        }
    }
    
    func addStocks(){
        for (stockName, stock) in Parameters.myStocks{
            initializeStocks(stockName, buyPrice: stock["buyPrice"]!, quantity: stock["quantity"]!, commission: stock["commission"]!)
        }
    }
}
