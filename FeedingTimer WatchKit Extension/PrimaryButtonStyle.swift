//
//  PrimaryButtonStyle.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 5/2/21.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		PrimaryStyleView(configuration: configuration)
	}
}

private extension PrimaryButtonStyle {
	struct PrimaryStyleView: View {
		@Environment(\.isEnabled) var isEnabled
		let configuration: PrimaryButtonStyle.Configuration
		
		var body: some View {
			return configuration.label
				.frame(maxWidth: .infinity)
				.padding()
				.background(isEnabled ? Color.mainColor : .gray)
				.cornerRadius(16)
				.foregroundColor(.white)
				.opacity(configuration.isPressed ? 0.8 : 1.0)
				.scaleEffect(configuration.isPressed ? 0.98 : 1.0)
		}
	}
}
