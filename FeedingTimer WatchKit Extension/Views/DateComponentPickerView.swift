//
//  DateComponentPickerView.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/29/21.
//

import SwiftUI

struct DateComponentPickerView: View {
	var label: String
	var interval: Int
	var intervalCount: Int
	@Binding var selection: Int
	var body: some View {
		VStack {
			Picker(selection: $selection, label: Text(label).font(.title3)) {
				ForEach((0..<intervalCount).map { $0 * interval }, id: \.self) { i in
					Text("\(i)").tag(i)
				}
			}.pickerStyle(WheelPickerStyle())
		}
	}
}
