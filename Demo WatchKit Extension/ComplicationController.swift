////
////  ComplicationController.swift
////  Demo WatchKit Extension
////
////  Created by George Jose on 2015-09-12.
////  Copyright © 2015 George Jose. All rights reserved.
////
//
//import ClockKit
//
//
//class ComplicationController: NSObject, CLKComplicationDataSource {
//    
//    
//    // MARK: - Timeline Configuration
//    
//    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
//        handler([.Forward])
//    }
//    
//    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
//        let currentDate = NSDate()
//        handler(currentDate)
//
//    }
//    
//    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
//        let currentDate = NSDate()
//        let endDate =
//        currentDate.dateByAddingTimeInterval(NSTimeInterval(4 * 60 * 60))
//        
//        handler(endDate)
//    }
//    
//    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
//        handler(.ShowOnLockScreen)
//    }
//    
//    // MARK: - Timeline Population
//    
//    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
//        // Call the handler with the current timeline entry
//        
//        if complication.family == .UtilitarianSmall {
//            let gainAmount = String(Portfolio.gainAmount)
//            let entry = createTimeLineEntry(gainAmount, bodyText: timeLineText[0], date: NSDate())
//            
//            handler(entry)
//        } else {
//            handler(nil)
//        }
//    }
//    
//    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
//        // Call the handler with the timeline entries prior to the given date
//        var timeLineEntryArray = [CLKComplicationTimelineEntry]()
//        var nextDate = NSDate(timeIntervalSinceNow: 1 * 60 * 60)
//        
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "hh:mm"
//        let timeString = dateFormatter.stringFromDate(nextDate)
//        let entry = createTimeLineEntry(timeString, bodyText:"", date: nextDate)
//        timeLineEntryArray.append(entry)
//        nextDate = nextDate.dateByAddingTimeInterval(1 * 60 * 60)
//        handler(timeLineEntryArray)
//
//    }
//    
//    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
//        // Call the handler with the timeline entries after to the given date
//        handler(nil)
//    }
//    
//    // MARK: - Update Scheduling
//    
//    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
//        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
//        handler(nil);
//    }
//    
//    // MARK: - Placeholder Templates
//    
//    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
//        // This method will be called once per supported complication, and the results will be cached
//        let template = CLKComplicationTemplateUtilitarianSmallFlat()
//        template.textProvider = CLKSimpleTextProvider(text: "AA")
//        template.tintColor = (UIColor.whiteColor())
//        handler(template)
//    }
//    
//    func createTimeLineEntry(text: String, bodyText: String, date: NSDate) -> CLKComplicationTimelineEntry {
//        let template = CLKComplicationTemplateUtilitarianSmallFlat()
//        template.textProvider = CLKSimpleTextProvider(text: text)
//        let entry = CLKComplicationTimelineEntry(date: date,
//            complicationTemplate: template)
//        return(entry)
//    }
//    
//}
