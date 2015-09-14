////
////  ComplicationController.swift
////  Demo WatchKit Extension
////
////  Created by George Jose on 2015-09-12.
////  Copyright © 2015 George Jose. All rights reserved.
////
//
import ClockKit


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
    let ComplicationCurrentEntry = "ComplicationCurrentEntry"
    let ComplicationTextData = "ComplicationTextData"
    let ComplicationShortTextData = "ComplicationShortTextData"
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication,
        withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
            // Get the complication data from the extension delegate.
            let myDelegate = WKExtension.sharedExtension().delegate as! ExtensionDelegate
            var data : Dictionary = myDelegate.myComplicationData[ComplicationCurrentEntry]!
            
            var entry : CLKComplicationTimelineEntry?
            let now = NSDate()
            
            // Create the template and timeline entry.
            if complication.family == .ModularSmall {
                let longText = data[ComplicationTextData]
                let shortText = data[ComplicationShortTextData]
                let textTemplate = CLKComplicationTemplateModularSmallSimpleText()
                textTemplate.textProvider = CLKSimpleTextProvider(text: longText, shortText: shortText)
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

        handler(nil);
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        let template = CLKComplicationTemplateUtilitarianSmallFlat()
        template.textProvider = CLKSimpleTextProvider(text: "AA")
        template.tintColor = (UIColor.whiteColor())
        handler(template)
    }
    
    func createTimeLineEntry(text: String, bodyText: String, date: NSDate) -> CLKComplicationTimelineEntry {
        let template = CLKComplicationTemplateUtilitarianSmallFlat()
        template.textProvider = CLKSimpleTextProvider(text: text)
        let entry = CLKComplicationTimelineEntry(date: date,
            complicationTemplate: template)
        return(entry)
    }
    
}
