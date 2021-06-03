//
//  TimerView.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/23/21.
//

import SwiftUI
import ClockKit

struct InitializeTimerView: View {
	@AppStorage("selectedHour") var selectedHour = DefaultTimerValues.hour
	@AppStorage("selectedMinutes") var selectedMinutes = DefaultTimerValues.minutes
	@AppStorage("nextFeedingTime")
	var nextFeedingTimeShadow: Double = 0
	
	var body: some View {
		VStack {
			GeometryReader { geometry in
				HStack(spacing: 0){
					DateComponentPickerView(label: NSLocalizedString("hour-abbreviation", comment: "Hours label for timer"), interval: 1, intervalCount: 12, selection: $selectedHour)
						.frame(maxWidth: geometry.size.width / 2)
						.clipped()
					DateComponentPickerView(label: NSLocalizedString("minutes-abbreviation", comment: "Minutes label for timer"), interval: 5, intervalCount: 12, selection: $selectedMinutes)
						.frame(maxWidth: geometry.size.width / 2)
						.clipped()
				}
			}.layoutPriority(1)
			Button(action: {
				let addedSeconds = Double((3600 * self.selectedHour) + (60 * self.selectedMinutes))
				let nextFeedingDate = Date(timeIntervalSinceNow: addedSeconds)
				nextFeedingTimeShadow = nextFeedingDate.timeIntervalSince1970
				NotificationManager().scheduleLocalNotification(timeIntervalSinceNow: addedSeconds, title: NSLocalizedString("notification-title", comment: "Notification title for the next baby feeding"), subtitle: NSLocalizedString("notification-subtitle", comment: "Notification subtitle for the next baby feeding"))
				ComplicationController.reloadComplications()
				
			}, label: {
				Text("start-text")
			})
			.buttonStyle(PrimaryButtonStyle())
			.disabled(selectedHour == 0 && selectedMinutes == 0)
		}
	}
}
