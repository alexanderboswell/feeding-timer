//
//  NotificationManager.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/28/21.
//

import Foundation
import UserNotifications

class NotificationManager {
	func AskForPermission() {
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
			if success {
				print("All set!")
			} else if let error = error {
				print(error.localizedDescription)
			}
		}
	}
	
	func scheduleLocalNotification(timeIntervalSinceNow: Double, title: String, subtitle: String) {
		let content = UNMutableNotificationContent()
		content.title = title
		content.subtitle = subtitle
		content.sound = UNNotificationSound.default
		print(timeIntervalSinceNow)
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeIntervalSinceNow, repeats: false)
		
		let identifier = UUID()
		let request = UNNotificationRequest(identifier: identifier.uuidString, content: content, trigger: trigger)
		
		UNUserNotificationCenter.current().add(request)
	}
	
	func removeLocationNotification() {
		UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
	}
}
