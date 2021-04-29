//
//  FeedingTimerApp.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/23/21.
//

import SwiftUI

@main
struct FeedingTimerApp: App {
	let timerManager = TimerManager()
	
	init() {
		timerManager.load()
		NotificationManager().AskForPermission()
	}
	
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
					.environmentObject(timerManager)
            }
        }
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}

struct FeedingTimerApp_Previews: PreviewProvider {
  static var previews: some View {
	ContentView().environmentObject(TimerManager())
  }
}
