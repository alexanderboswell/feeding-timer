//
//  ContentView.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/23/21.
//

import SwiftUI
private var DEFAULT_HOUR: Int = 3
private var DEFAULT_MINUTE: Int = 0
struct ContentView: View {
	@EnvironmentObject var timerManager: TimerManager
	
	var body: some View {
		if timerManager.nextFeeding != nil {
			CountdownView()
		} else {
			InitializeTimerView(selectedHour: $timerManager.selectedHour, selectedMinutes: $timerManager.selectedMinutes)
		}
	}
	
	struct ContentView_Previews: PreviewProvider {
		static var previews: some View {
			ContentView()
		}
	}
}
