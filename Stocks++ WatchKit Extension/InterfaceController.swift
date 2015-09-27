//
//  InterfaceController.swift
//  Stocks++ WatchKit Extension
//
//  Created by George Jose on 2015-09-24.
//  Copyright © 2015 George Jose. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var marketValueOutlet: WKInterfaceLabel!
    @IBAction func refreshButtonAction() {
        Portfolio.done = false
        clearUI()
        computeAndUpdate()
        
    }
    @IBAction func switchTableAction() {
        switchTable()
    }
    @IBOutlet weak var stockTable: WKInterfaceTable!
    @IBOutlet var gainAmountOutlet: WKInterfaceLabel!
    @IBOutlet var gainPercentOutlet: WKInterfaceLabel!
    @IBOutlet var daysGainAmountOutlet: WKInterfaceLabel!
    @IBOutlet var daysGainOutlet: WKInterfaceLabel!
    @IBOutlet var costBasisOutlet: WKInterfaceLabel!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        computeAndUpdate()
    }
    

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func computeAndUpdate(){
        Portfolio.initialize()
        Portfolio.updatePortfolio()
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            self.waitTillUpdated()
            dispatch_async(dispatch_get_main_queue()) {
                self.updateUI()
            }
        }
    }
    
    func reloadTable() {
        stockTable.setNumberOfRows(Portfolio.stocks.count, withRowType: "StockRow")
        var i: Int = 0
        for (symbol, stock) in Portfolio.stocks {
            if let row = stockTable.rowControllerAtIndex(i) as? StockRow {
                row.symbolOutlet.setText(symbol)
                UI.setText(row.priceOutlet, amount: stock.price , format: "abs")
                UI.setText(row.daysChangeAmountOutlet, amount: stock.change, format: "$")
                UI.setText(row.daysChangePercentOutlet, amount: stock.daysGainPercentT , format: "%")
            }
            i = i + 1
        }
    }
    
    func switchTable(){
        if(Constants.toggle == true){
            var i: Int = 0
            for (symbol, stock) in Portfolio.stocks {
                if let row = stockTable.rowControllerAtIndex(i) as? StockRow {
                    UI.setText(row.daysChangeAmountOutlet, amount: stock.gainAmountT, format: "$")
                    UI.setText(row.daysChangePercentOutlet, amount: stock.gainPercentT , format: "%")
                }
                i = i + 1
            }
            Constants.toggle = false
        } else{
            var i: Int = 0
            for (symbol, stock) in Portfolio.stocks {
                if let row = stockTable.rowControllerAtIndex(i) as? StockRow {
                    UI.setText(row.daysChangeAmountOutlet, amount: stock.change, format: "$")
                    UI.setText(row.daysChangePercentOutlet, amount: stock.daysGainPercentT , format: "%")
                }
                i = i + 1
            }
            Constants.toggle = true
        }
        
    }
    
    func updateUI(){
        UI.setText(self.gainAmountOutlet, amount: Portfolio.gainAmount, format: "$")
        UI.setText(self.gainPercentOutlet, amount: Portfolio.gainPercent, format: "%")
        UI.setText(self.daysGainOutlet, amount: Portfolio.daysGainPercent, format: "%")
        UI.setText(daysGainAmountOutlet, amount: Portfolio.daysGainAmount, format: "$")
        UI.setText(marketValueOutlet, amount: Portfolio.marketValue, format: "abs")
        UI.setText(costBasisOutlet, amount: Portfolio.costBasis, format: "abs")
        reloadTable()
    }
    
    
    
    func clearUI(){
        UI.clear(gainAmountOutlet)
        UI.clear(gainPercentOutlet)
        UI.clear(daysGainOutlet)
        UI.clear(daysGainAmountOutlet)
        UI.clear(marketValueOutlet)
        UI.clear(costBasisOutlet)
        stockTable.setNumberOfRows(0, withRowType: "StockRow")
    }
    
    func waitTillUpdated(){
        while(Portfolio.done != true){
            if(Portfolio.done == true){
                break;
            }
        }
        print("Portfolio.done = true")
        return
    }
    
    
}
