//
//  ComplicationController.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/23/21.
//

import ClockKit
import SwiftUI


class ComplicationController: NSObject, CLKComplicationDataSource {
	
	// MARK: - Complication Configuration
	
	func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
		let descriptors = [
			CLKComplicationDescriptor(identifier: "nextFeedingComplication", displayName: "Feeding Timer", supportedFamilies: [CLKComplicationFamily.graphicCorner, CLKComplicationFamily.graphicCircular, CLKComplicationFamily.circularSmall, CLKComplicationFamily.modularSmall, CLKComplicationFamily.extraLarge, CLKComplicationFamily.graphicBezel, CLKComplicationFamily.graphicExtraLarge, CLKComplicationFamily.modularLarge, CLKComplicationFamily.utilitarianSmallFlat, CLKComplicationFamily.utilitarianLarge, CLKComplicationFamily.graphicRectangular])
		]
		
		// Call the handler with the currently supported complication descriptors
		handler(descriptors)
	}
	
	func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
		// Do any necessary work to support these newly shared complication descriptors
	}
	
	// MARK: - Timeline Configuration
	
	func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
		// Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
		handler(nil)
	}
	
	func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
		// Call the handler with your desired behavior when the device is locked
		handler(.showOnLockScreen)
	}
	
	func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
		guard let data = UserDefaults.standard.value(forKey: "nextFeedingTime") as? Double , data != DateState.notSet.rawValue  else {
			handler(nil)
			return
		}
		let nextFeedingTime = Date(timeIntervalSince1970: data)
		guard let template = getComplicationTemplate(for: complication) else {
			handler(nil)
			return
		}
		handler([CLKComplicationTimelineEntry(date: nextFeedingTime, complicationTemplate: template)])
		
	}
	
	// MARK: - Sample Templates
	
	func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
		if let template = getComplicationTemplate(for: complication, templateText: "1:06") {
			handler(template)
		} else {
			handler(nil)
		}
	}
	
	func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
		if let data = UserDefaults.standard.value(forKey: "nextFeedingTime") as? Double , data != DateState.notSet.rawValue {
			let nextFeedingTime = Date(timeIntervalSince1970: data)
			if let template = getComplicationTemplate(for: complication, nextFeedingTime: nextFeedingTime) {
				let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
				handler(entry)
			} else {
				handler(nil)
			}
		} else {
			if let template = getComplicationTemplate(for: complication) {
				let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
				handler(entry)
			} else {
				handler(nil)
			}
		}
	}
	
	static func reloadComplications() {
		let server = CLKComplicationServer.sharedInstance()
		for complication in server.activeComplications ?? [] {
			server.reloadTimeline(for: complication)
		}
	}
	
	func getComplicationTemplate(for complication: CLKComplication, nextFeedingTime: Date? = nil, templateText: String? = nil) -> CLKComplicationTemplate? {
		
		var nextFeedingTimeText = ""
		var meridiemText = "PM"
		var nextFeedingSet = false
		if let complicationText = templateText {
			nextFeedingTimeText = complicationText
			nextFeedingSet = true
		} else if let data = nextFeedingTime {
			nextFeedingSet = true
			let dateFormatterPrint = DateFormatter()
			dateFormatterPrint.dateFormat = "h:mm"
			nextFeedingTimeText = dateFormatterPrint.string(from: data)
			dateFormatterPrint.dateFormat = "a"
			meridiemText = dateFormatterPrint.string(from: data)
		}

		let appTitleText = NSLocalizedString("app-title", comment: "The title of the application")
		let simpleUnsetText = NSLocalizedString("unset-complication-simple", comment: "A message when the next feeding is not set")
		let simpleDateTextProvider = CLKSimpleTextProvider(text:  nextFeedingSet ? nextFeedingTimeText : simpleUnsetText)
		let simpleDateMeridiemTextProvider = CLKSimpleTextProvider(text:  nextFeedingSet ? nextFeedingTimeText + meridiemText : simpleUnsetText)
		let verboseUnsetText = NSLocalizedString("unset-complication-verbose", comment: "A message when the next feeding is not set")
		let verboseSetText = NSLocalizedString("set-complication-verbose", comment: "A message when the next feeding is set") + " ";
		let emptyTimeText = "--:--"
		switch complication.family {
		case .graphicCorner:
			return CLKComplicationTemplateGraphicCornerTextImage(textProvider: simpleDateMeridiemTextProvider, imageProvider: CLKFullColorImageProvider(fullColorImage: UIImage(named: "Complication/Graphic Corner")!))
		case .graphicCircular:
			return CLKComplicationTemplateGraphicCircularView(ComplicationViewCircular(text: nextFeedingSet ? nextFeedingTimeText : simpleUnsetText))
		case .circularSmall:
			return CLKComplicationTemplateCircularSmallStackImage(line1ImageProvider:  CLKImageProvider(onePieceImage: UIImage(named: "Complication/Circular")!), line2TextProvider: simpleDateTextProvider)
		case .modularSmall:
			return CLKComplicationTemplateModularSmallStackImage(line1ImageProvider: CLKImageProvider(onePieceImage: UIImage(named: "Complication/Modular")!), line2TextProvider: simpleDateMeridiemTextProvider)
		case .extraLarge:
			return CLKComplicationTemplateExtraLargeStackImage(line1ImageProvider: CLKImageProvider(onePieceImage: UIImage(named: "Complication/Extra Large")!), line2TextProvider: simpleDateMeridiemTextProvider)
		case .graphicBezel:
			let textProvider = CLKSimpleTextProvider(text: nextFeedingSet ? verboseSetText + nextFeedingTimeText + meridiemText : verboseUnsetText)
			return CLKComplicationTemplateGraphicBezelCircularText(circularTemplate: CLKComplicationTemplateGraphicCircularImage(imageProvider: CLKFullColorImageProvider(fullColorImage: UIImage(named: "Complication/Graphic Bezel")!)), textProvider: textProvider)
		case .graphicExtraLarge:
			guard #available(watchOSApplicationExtension 7.0, *) else {
				return nil
			}
			return CLKComplicationTemplateGraphicExtraLargeCircularView(
				ComplicationViewExtraLargeCircular(
					text: nextFeedingSet ? nextFeedingTimeText + " " + meridiemText : simpleUnsetText))
		case .modularLarge:
			let headerTextProvider = CLKSimpleTextProvider(text:  nextFeedingSet ? verboseSetText : verboseUnsetText)
			headerTextProvider.tintColor = UIColor(Color.mainColor)
			let bodyTextProvider = CLKSimpleTextProvider(text:  nextFeedingSet ? nextFeedingTimeText + meridiemText : emptyTimeText)
			return CLKComplicationTemplateModularLargeTallBody(headerTextProvider: headerTextProvider, bodyTextProvider: bodyTextProvider)
		case .utilitarianSmallFlat:
			return CLKComplicationTemplateUtilitarianSmallFlat(textProvider: simpleDateMeridiemTextProvider, imageProvider: CLKImageProvider(onePieceImage: UIImage(named: "Complication/Utilitarian")!))
		case .utilitarianLarge:
			return CLKComplicationTemplateUtilitarianLargeFlat(textProvider: CLKSimpleTextProvider(text: nextFeedingSet ? nextFeedingTimeText + meridiemText : verboseUnsetText), imageProvider: CLKImageProvider(onePieceImage: UIImage(named: "Complication/Utilitarian")!))
		case .graphicRectangular:
			let headerTextProvider = CLKSimpleTextProvider(text: appTitleText)
			headerTextProvider.tintColor = UIColor(Color.mainColor)
			let body1TextProvider = CLKSimpleTextProvider(text:  nextFeedingSet ? verboseSetText : verboseUnsetText)
			let body2TextProvider = CLKSimpleTextProvider(text:  nextFeedingSet ? nextFeedingTimeText + meridiemText : emptyTimeText)
			return CLKComplicationTemplateGraphicRectangularStandardBody(headerTextProvider: headerTextProvider, body1TextProvider: body1TextProvider, body2TextProvider: body2TextProvider)
		default:
			return nil
		}
	}
}
