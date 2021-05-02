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
	static let NotificationIdentifierKey = "next-feeding-notification"
	static let SelectedHourKey = "selected-hour"
	static let SelectedMinutesKey = "selected-minutes"
}

final class TimerManager: ObservableObject {
	@Published var nextFeeding: Date?
	@Published var notificationIdentifier: UUID?
	@Published var selectedHour: Int = 0
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
		
		if let data = UserDefaults.standard.value(forKey: TimerManagerConstants.NotificationIdentifierKey) as? UUID {
			self.notificationIdentifier = data
		}
		
		if let data = UserDefaults.standard.value(forKey: TimerManagerConstants.NextFeedingKey) as? Date {
			
			if data <= Date() {
				self.nextFeeding = nil
			} else {
				self.nextFeeding = data
			}
		}
	}
	
	func clear() {
		UserDefaults.standard.removeObject(forKey: TimerManagerConstants.NextFeedingKey)
		UserDefaults.standard.removeObject(forKey: TimerManagerConstants.NotificationIdentifierKey)
		UserDefaults.standard.removeObject(forKey: TimerManagerConstants.SelectedHourKey)
		UserDefaults.standard.removeObject(forKey: TimerManagerConstants.SelectedMinutesKey)
		self.nextFeeding = nil
		self.notificationIdentifier = nil
	}
	
	private func persist() {
		UserDefaults.standard.set(nextFeeding, forKey: TimerManagerConstants.NextFeedingKey)
		UserDefaults.standard.set(notificationIdentifier, forKey: TimerManagerConstants.NotificationIdentifierKey)
		UserDefaults.standard.set(selectedHour, forKey: TimerManagerConstants.SelectedHourKey)
		UserDefaults.standard.set(selectedMinutes, forKey: TimerManagerConstants.SelectedMinutesKey)
	}
	
}
