////
////  StocksComplication.swift
////  Demo
////
////  Created by George Jose on 2015-09-14.
////  Copyright © 2015 George Jose. All rights reserved.
////
//
//import ClockKit
//
//class StocksComplication: NSObject, CLKComplicationDataSource {
//    
//    func getCurrentHealth()->Double{
//        return 25.0
//    }
//    
//    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
//        handler(NSDate(timeIntervalSinceNow: 60*60))
//    }
//    
//    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
//        var template: CLKComplicationTemplate? = nil
//        switch complication.family {
//        case .ModularSmall:
//            template = nil
//        case .ModularLarge:
//            template = nil
//        case .UtilitarianSmall:
//            template = nil
//        case .UtilitarianLarge:
//            template = nil
//        case .CircularSmall:
//            let modularTemplate = CLKComplicationTemplateCircularSmallRingText()
//            modularTemplate.textProvider = CLKSimpleTextProvider(text: "--")
//            modularTemplate.fillFraction = 0.7
//            modularTemplate.ringStyle = CLKComplicationRingStyle.Closed
//            template = modularTemplate
//        }
//        handler(template)
//    }
//    
//    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
//        handler(CLKComplicationPrivacyBehavior.ShowOnLockScreen)
//    }
//    
//    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimelineEntry?) -> Void) {
//        handler(nil)
//    }
//    
//    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: ([CLKComplicationTimelineEntry]?) -> Void) {
//        if complication.family == .CircularSmall {
//            let template = CLKComplicationTemplateCircularSmallRingText()
//            template.textProvider = CLKSimpleTextProvider(text: "\(getCurrentHealth())")
//            template.fillFraction = Float(getCurrentHealth()) / 10.0
//            template.ringStyle = CLKComplicationRingStyle.Closed
//            
//            let timelineEntry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template)
//            handler(timelineEntry)
//        } else {
//            handler(nil)
//        }
//    }
//    
//    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: ([CLKComplicationTimelineEntry]?) -> Void) {
//        handler([])
//    }
//    
//    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
//        handler([CLKComplicationTimeTravelDirections.None])
//    }
//    
//    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
//        handler(NSDate())
//    }
//    
//    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
//        handler(NSDate())
//    }
//}