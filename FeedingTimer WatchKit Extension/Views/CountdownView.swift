//
//  CountdownView.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/28/21.
//

import SwiftUI


struct CountdownView: View {
	@State var isViewDisplayed = false
	@State var date: Date = Date() {
		didSet {
			checkNextFeedingDate()
		}
	}
	@AppStorage("nextFeedingTime")
	var nextFeedingTimeShadow: Double = 0
	@State var nextFeedingTime: Date?
	
	var timer: Timer {
		Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
			if isViewDisplayed {
				self.date = Date()
			}
		}
	}

	var body: some View {
		VStack {
			if nextFeedingTime != nil {
				Text(nextFeedingTime!.advanced(by: TimeInterval(1)), style: .timer)
					.onAppear(perform: {
						_ = self.timer
					})
					.font(Font.largeTitle.monospacedDigit())
					.accessibility(identifier: "TimerCountdown")
			}
			Button(action: {
				NotificationManager().removeLocationNotification()
				nextFeedingTimeShadow = DateState.notSet.rawValue
				ComplicationController.reloadComplications()
			}, label: {
				Text("cancel-text")
			})
		}
		.onAppear {
			self.isViewDisplayed = true
			checkNextFeedingDate()
		}
		.onDisappear {
			self.isViewDisplayed = false
		}
	}

	func checkNextFeedingDate() {
		let currentNextFeeding = Date(timeIntervalSince1970: nextFeedingTimeShadow)
		if currentNextFeeding < Date() {
			nextFeedingTime = nil
			nextFeedingTimeShadow = DateState.notSet.rawValue
		} else {
			nextFeedingTime = currentNextFeeding
		}
	}
}
