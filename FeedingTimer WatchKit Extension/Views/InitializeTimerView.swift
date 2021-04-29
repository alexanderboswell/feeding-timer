//
//  TimerView.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/23/21.
//

import SwiftUI

struct InitializeTimerView: View {
	@EnvironmentObject var timerManager: TimerManager
	@Binding var selectedHour: Int
	@Binding var selectedMinutes: Int
	
	var body: some View {
		VStack {
			Text("timer-headline")
				.bold()
			GeometryReader { geometry in
				HStack(spacing: 0){
					DateComponentPickerView(label: NSLocalizedString("hour-abbreviation", comment: "Hours label for timer"), interval: 1, intervalCount: 13, selection: $selectedHour)
						.frame(maxWidth: geometry.size.width / 2)
						.clipped()
					DateComponentPickerView(label: NSLocalizedString("minutes-abbreviation", comment: "Minutes label for timer"), interval: 5, intervalCount: 12, selection: $selectedMinutes)
						.frame(maxWidth: geometry.size.width / 2)
						.clipped()
				}
			}.layoutPriority(1)
			Spacer()
			Button(action: {
				self.timerManager.setNextFeeding()
				self.timerManager.notificationIdentifier = NotificationManager().scheduleLocalNotification(date: self.timerManager.nextFeeding, title: NSLocalizedString("notification-title", comment: "Notification title for the next baby feeding"), subtitle: NSLocalizedString("notification-subtitle", comment: "Notification subtitle for the next baby feeding"))
				
			}, label: {
				Text("start-text")
			})
		}
	}
}

struct InitializeTimerView_Previews: PreviewProvider {
	static var previews: some View {
		InitializeTimerView(selectedHour: .constant(5), selectedMinutes: .constant(45)).environmentObject(TimerManager())
	}
}
