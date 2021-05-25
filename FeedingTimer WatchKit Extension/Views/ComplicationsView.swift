//
//  ComplicationsView.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 5/24/21.
//

import SwiftUI
import ClockKit

struct ComplicationViewCircular: View {
	@State var text: String

	var body: some View {
		VStack {
			Image("Complication/Graphic Corner")
			Text("\(text)")
			Spacer()
			Spacer()
		}
	}
}

struct ComplicationViewExtraLargeCircular: View {
	@State var text: String

	var body: some View {
		VStack {
			Image("Complication/Extra Large")
				.resizable()
				.scaledToFit()
				.complicationForeground()
				Text("\(text)")
					.minimumScaleFactor(0.1)
					.lineLimit(1)
					.padding(.horizontal, 12)
					.complicationForeground()
			Spacer()
			Spacer()
		}.padding(.vertical)
	}
}

struct ComplicationsView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			CLKComplicationTemplateGraphicExtraLargeCircularView(
				ComplicationViewExtraLargeCircular(text: "10:06 PM")
			).previewContext(faceColor: .pink)
			// Spanish meridiem
			CLKComplicationTemplateGraphicExtraLargeCircularView(
				ComplicationViewExtraLargeCircular(text: "10:06 p. m.")
			).previewContext(faceColor: .orange)
			CLKComplicationTemplateGraphicCircularView(
				ComplicationViewCircular(text: "1:06")
			).previewContext(faceColor: .multicolor)
			CLKComplicationTemplateGraphicCircularView(
				ComplicationViewCircular(text: "10:06")
			).previewContext(faceColor: .green)
			CLKComplicationTemplateGraphicCircularView(
				ComplicationViewCircular(text: NSLocalizedString("unset-complication-simple", comment: "A message when the next feeding is not set"))
			).previewContext(faceColor: .blue)
		}
	}
}
