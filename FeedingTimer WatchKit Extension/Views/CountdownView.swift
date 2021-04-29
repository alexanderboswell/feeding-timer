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
				Text(getTimerText(from: date, to: timerManager.nextFeeding!))
					.onAppear(perform: {
						_ = self.timer
					})
			}
			Button(action: {
				NotificationManager().removeLocationNotification(identifier: self.timerManager.notificationIdentifier)
				self.timerManager.clear()
			}, label: {
				Text("cancel-text")
			})
		}
	}
	
	func getTimerText(from startDate: Date, to endDate: Date) -> String {
		let calendar = Calendar(identifier: .gregorian)
		let timeValue = calendar.dateComponents([.hour, .minute, .second], from: startDate, to: endDate)
		
		guard let hour = timeValue.hour, let minute = timeValue.minute, let second = timeValue.second  else {
			return String()
		}
		return String(format: "%02d:%02d:%02d", hour, minute, second)
	}
}

struct CountdownView_Previews: PreviewProvider {
	static var previews: some View {
		CountdownView()
	}
}
