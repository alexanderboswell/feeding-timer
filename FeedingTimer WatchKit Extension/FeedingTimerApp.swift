//
//  FeedingTimerApp.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/23/21.
//

import SwiftUI

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
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}

struct FeedingTimerApp_Previews: PreviewProvider {
  static var previews: some View {
	ContentView()
  }
}
