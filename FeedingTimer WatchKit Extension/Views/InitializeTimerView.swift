//
//  TimerView.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/23/21.
//

import SwiftUI

struct InitializeTimerView: View {
	@EnvironmentObject var timerManager: TimerManager
	@Binding var selectedHour: Int
	@Binding var selectedMinutes: Int
	
	var body: some View {
		VStack {
			Text("Next feeding in...")
				.bold()
			GeometryReader { geometry in
				HStack(spacing: 0){
					Picker("", selection: $selectedHour){
						ForEach(0..<13, id: \.self) { i in
							Text("\(i) hrs").tag(i)
						}
					}.pickerStyle(WheelPickerStyle())
					.frame(maxWidth: geometry.size.width / 2)
					.clipped()
					Picker("", selection: $selectedMinutes){
						ForEach((0..<12).map { $0 * 5 }, id: \.self) { i in
							Text("\(i) min").tag(i)
						}
					}.pickerStyle(WheelPickerStyle())
					.frame(maxWidth: geometry.size.width / 2)
					.clipped()
				}
			}
			Spacer()
			Button(action: {
				self.timerManager.setNextFeeding()
				// TODO
				_ = NotificationManager().scheduleLocalNotification(date: self.timerManager.nextFeeding, title: "Next feeding!", subtitle: "Its time to feed")
			}, label: {
				Text("Start")
			})
		}
	}
}

struct InitializeTimerView_Previews: PreviewProvider {
	static var previews: some View {
		InitializeTimerView(selectedHour: .constant(5), selectedMinutes: .constant(45)).environmentObject(TimerManager())
	}
}
