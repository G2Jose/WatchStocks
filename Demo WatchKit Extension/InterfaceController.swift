//
//  InterfaceController.swift
//  Demo WatchKit Extension
//
//  Created by George Jose on 2015-09-12.
//  Copyright © 2015 George Jose. All rights reserved.
//

import WatchKit
import Foundation
import ClockKit

class InterfaceController: WKInterfaceController {

    @IBOutlet var tableOutlet: WKInterfaceTable!
    @IBOutlet var daysGainOutlet: WKInterfaceLabel!
    
    @IBOutlet var gainOutlet: WKInterfaceLabel!
    
    @IBOutlet var gainPercentOutlet: WKInterfaceLabel!
    @IBAction func refreshButtonAction() {
        print("---------REFRESH BUTTON PRESSED---------")
        Portfolio.clearPortfolio()
        addStocks()
        update()
    }
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    override func willActivate() {
        super.willActivate()
        Portfolio.clearPortfolio()
        addStocks()
        update()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    func initializeStocks(query: String, buyPrice: Double, quantity: Double, commission: Double){
        Portfolio.addStock(Stock(query: query, buyPrice: buyPrice, quantity: quantity, commission: commission))
    }
    
    enum JSONError: String, ErrorType {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    func update(){
        print("Running update()")
        Portfolio.updateStocks()
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            while(Portfolio.stocksToUpdate != 0){
                //TODO: Code breaks if the next line is removed.
                var doSomething = true;
                if(Portfolio.stocksToUpdate == 0){
                    break
                }
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                Portfolio.updatePortfolio()
                Portfolio.log("stocksToUpdate = \(Portfolio.stocksToUpdate)")
                Portfolio.log("Updating UI")
                print("Day's gain \(Portfolio.daysGain)")
                print("Total gain \(Portfolio.gainAmount)")
                print("Gain % \(Portfolio.gainPercent)")
                
                self.gainOutlet.setText(HF.string(Portfolio.gainAmount, format: "$"))
                self.gainOutlet.setTextColor(HF.getColor(Portfolio.gainAmount))
                
                self.gainPercentOutlet.setText(HF.string(Portfolio.gainPercent, format: "%"))
                self.gainPercentOutlet.setTextColor(HF.getColor(Portfolio.gainPercent))
                
                self.daysGainOutlet.setText(HF.string(Portfolio.daysGain, format: "$"))
                self.daysGainOutlet.setTextColor(HF.getColor(Portfolio.daysGain))
                self.tableOutlet.setNumberOfRows(Portfolio.stocks.count
                    , withRowType: "TableRowController")
                var i = 0
                for (_, stock) in Portfolio.stocks {
                    let row = self.tableOutlet.rowControllerAtIndex(i) as! TableRowController
                    row.symbolOutlet.setText(stock.symbol)
                    row.gainAmountOutlet.setText(HF.string(stock.gainAmount, format: "$"))
                    row.gainAmountOutlet.setTextColor(HF.getColor(stock.gainPercent))
                    row.gainPercentOutlet.setText(HF.string(stock.gainPercent, format: "%"))
                    row.gainPercentOutlet.setTextColor(HF.getColor(stock.gainPercent))
                    row.stockPriceOutlet.setText("$" + String(format: "%.2f", stock.currentPrice))
                    i++
                }
                
                
            }
        }
    }
    
    func addStocks(){
        for (stockName, stock) in Parameters.myStocks{
            initializeStocks(stockName, buyPrice: stock["buyPrice"]!, quantity: stock["quantity"]!, commission: stock["commission"]!)
        }
    }
}
