//
//  FeedingTimerApp.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/23/21.
//

import SwiftUI
import UserNotifications
import Foundation


@main
struct FeedingTimerApp: App {
	
	init() {
		NotificationManager().AskForPermission()
	}
	
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
        WKNotificationScene(controller: NotificationController.self, category: "NextFeedingTime")
    }
}

struct FeedingTimerApp_Previews: PreviewProvider {
  static var previews: some View {
	ContentView()
  }
}
