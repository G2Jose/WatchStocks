//
//  ComplicationController.swift
//  Demo WatchKit Extension
//
//  Created by George Jose on 2015-09-12.
//  Copyright © 2015 George Jose. All rights reserved.
//

import ClockKit
import WatchKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        let currentDate = NSDate()
        handler(currentDate)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        let currentDate = NSDate()
        let endDate =
        currentDate.dateByAddingTimeInterval(NSTimeInterval(4 * 60 * 60))
        handler(endDate)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    // Keys for accessing the complicationData dictionary.
//    let ComplicationCurrentEntry = "ComplicationCurrentEntry"
//    let ComplicationTextData = "ComplicationTextData"
//    let ComplicationShortTextData = "ComplicationShortTextData"
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication,
        withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
            // Get the complication data from the extension delegate.
            let myDelegate = WKExtension.sharedExtension().delegate as! ExtensionDelegate
//            var data : Dictionary = myDelegate.myComplicationData[ComplicationCurrentEntry]!
            
            var entry : CLKComplicationTimelineEntry?
            let now = NSDate()
            
            // Create the template and timeline entry.
            print("----------------------------------------")
            print("creating complication")
            print("----------------------------------------")
            if complication.family == .UtilitarianSmall {
                let gainPercent = Portfolio.gainPercent
//                var gainAmount = Portfolio.gainAmount
                var longText = ""
                var complicationColor = UIColor.whiteColor()
                if (gainPercent > 0){
                    longText = "+" + "$" + String(format: "%.2f", Portfolio.daysGain)
                    complicationColor = UIColor.greenColor()
                }else{
                    longText = "-" + "$" + String(format: "%.2f", Portfolio.daysGain) + "%"
                    complicationColor = UIColor.redColor()
                }
                let textTemplate = CLKComplicationTemplateUtilitarianSmallFlat()
                textTemplate.textProvider = CLKSimpleTextProvider(text: longText)
                textTemplate.tintColor = UIColor.greenColor()
                // Create the entry.
                entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: textTemplate)
            }
            else {
                // ...configure entries for other complication families.
            }
            // Pass the timeline entry back to ClockKit.
            handler(entry)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        handler(nil)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        let nextUpdateDate:NSDate = NSDate()
        let interval:NSTimeInterval = 900
        nextUpdateDate.addTimeInterval(interval)
        handler(nextUpdateDate);
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        handler(nil)
    }
    
    func createTimeLineEntry(text: String, bodyText: String, date: NSDate) -> CLKComplicationTimelineEntry {
        let template = CLKComplicationTemplateUtilitarianSmallFlat()
        template.textProvider = CLKSimpleTextProvider(text: text)
        let entry = CLKComplicationTimelineEntry(date: date,
            complicationTemplate: template)
        return(entry)
    }
    
}
