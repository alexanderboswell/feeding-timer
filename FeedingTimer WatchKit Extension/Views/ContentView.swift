//
//  ContentView.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/23/21.
//

import SwiftUI

struct ContentView: View {
	@AppStorage("nextFeedingTime")
	var nextFeedingTimeShadow: Double = DateState.notSet.rawValue
	@State var nextFeedingTime: Date = Date()

	var body: some View {
		VStack {
			Text("timer-headline")
				.bold()
			if nextFeedingTimeShadow != DateState.notSet.rawValue {
				CountdownView()
			} else {
				InitializeTimerView()
			}
		}.onAppear {
			let date = Date(timeIntervalSince1970: nextFeedingTimeShadow)
			if date < Date() {
				nextFeedingTimeShadow = DateState.notSet.rawValue
			}
		}
	}
	
	struct ContentView_Previews: PreviewProvider {
		static var previews: some View {
			ContentView()
		}
	}
}
