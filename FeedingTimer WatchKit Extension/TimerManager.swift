//
//  TImerManager.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/28/21.
//

import Foundation
import SwiftUI
import Combine

struct TimerManagerConstants {
	static let NextFeedingKey = "next-feeding"
	static let SelectedHourKey = "selected-hour"
	static let SelectedMinutesKey = "selected-minutes"
}

final class TimerManager: ObservableObject {
	@Published var nextFeeding: Date?
	@Published var selectedHour: Int = 3
	@Published var selectedMinutes: Int = 0

	func setNextFeeding() {
		let addedSeconds = Double((3600 * self.selectedHour) + (60 * self.selectedMinutes))
		self.nextFeeding = Date(timeIntervalSinceNow: addedSeconds)
		self.persist()
		
	}
	
	func load() {
		if let data = UserDefaults.standard.value(forKey: TimerManagerConstants.SelectedHourKey) as? Int {
			self.selectedHour = data
		}
		
		if let data = UserDefaults.standard.value(forKey: TimerManagerConstants.SelectedMinutesKey) as? Int {
			self.selectedMinutes = data
		}
		if let data = UserDefaults.standard.value(forKey: TimerManagerConstants.NextFeedingKey) as? Date {
			self.nextFeeding = data
		}
	}
	
	func clear() {
		UserDefaults.standard.removeObject(forKey: TimerManagerConstants.NextFeedingKey)
		UserDefaults.standard.removeObject(forKey: TimerManagerConstants.SelectedHourKey)
		UserDefaults.standard.removeObject(forKey: TimerManagerConstants.SelectedMinutesKey)
		self.nextFeeding = nil
	}
	
	private func persist() {
		UserDefaults.standard.set(nextFeeding, forKey: TimerManagerConstants.NextFeedingKey)
		UserDefaults.standard.set(selectedHour, forKey: TimerManagerConstants.SelectedHourKey)
		UserDefaults.standard.set(selectedMinutes, forKey: TimerManagerConstants.SelectedMinutesKey)
	}
	
}
