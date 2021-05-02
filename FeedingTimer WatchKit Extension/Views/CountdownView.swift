//
//  CountdownView.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/28/21.
//

import SwiftUI

struct CountdownView: View {
	@EnvironmentObject var timerManager: TimerManager
	@State var date: Date = Date()
	
	var timer: Timer {
		Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
			self.date = Date()
		}
	}
	
	var body: some View {
		VStack {
			if timerManager.nextFeeding != nil {
				Text(timerManager.nextFeeding!, style: .timer)
					.onAppear(perform: {
						_ = self.timer
					})
					.font(Font.largeTitle.monospacedDigit())	
			}
			Button(action: {
				NotificationManager().removeLocationNotification(identifier: self.timerManager.notificationIdentifier)
				self.timerManager.clear()
			}, label: {
				Text("cancel-text")
			})
		}
	}
}
