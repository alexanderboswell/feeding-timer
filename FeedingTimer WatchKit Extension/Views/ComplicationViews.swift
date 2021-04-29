//
//  ComplicationViews.swift
//  FeedingTimer WatchKit Extension
//
//  Created by alexander boswell on 4/23/21.
//

import SwiftUI
import ClockKit

struct ComplicationViews: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ComplicationViewCornerCircular: View {
	@Environment(\.complicationRenderingMode) var renderingMode

	var body: some View {
		ZStack {
			switch renderingMode {
			case .fullColor:
				Circle()
					.fill(Color.black)
			case .tinted:
				Circle()
					.fill(Color.clear)
//						RadialGradient(
//							gradient: Gradient(colors: [.clear, .white]),
//							center: .center,
//							startRadius: 10,
//							endRadius: 15))
			@unknown default:
				Circle()
			}
			Text("test")
			Circle()
				.stroke(Color(UIColor.blue), lineWidth: 5)
				.complicationForeground()
		}
	}
}


struct ComplicationViews_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			CLKComplicationTemplateGraphicCornerCircularView(
				ComplicationViewCornerCircular()
			).previewContext(faceColor: .red)
			
			CLKComplicationTemplateGraphicCornerCircularView(
				ComplicationViewCornerCircular()
			).previewContext()
		}
    }
}
