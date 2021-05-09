//
//  CountdownView.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/28/21.
//

import SwiftUI

struct CountdownView: View {
	@State var date: Date = Date()
	@AppStorage("nextFeedingTime")
	var nextFeedingTimeShadow: Double = 0
	@State var nextFeedingTime: Date?
	
	var timer: Timer {
		Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
			self.date = Date()
		}
	}
	
	var body: some View {
		VStack {
			if nextFeedingTime != nil {
				Text(nextFeedingTime!, style: .timer)
					.onAppear(perform: {
						_ = self.timer
					})
					.font(Font.largeTitle.monospacedDigit())	
			}
			Button(action: {
				NotificationManager().removeLocationNotification()
				nextFeedingTimeShadow = DateState.notSet.rawValue
			}, label: {
				Text("cancel-text")
			})
		}
		.onAppear {
			let currentNextFeeding = Date(timeIntervalSince1970: nextFeedingTimeShadow)
			if currentNextFeeding < Date() {
				nextFeedingTime = nil
			} else {
				nextFeedingTime = currentNextFeeding
			}
		}
	}
}
