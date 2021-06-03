//
//  FeedingTimer_AppUI_Tests.swift
//  FeedingTimer AppUI Tests
//
//  Created by alexander boswell on 5/25/21.
//

import XCTest
import Foundation
import UserNotifications

class FeedingTimer_AppUI_Tests: XCTestCase {

	override func setUpWithError() throws {
		continueAfterFailure = false
	}

	override func tearDownWithError() throws {
		let app = XCUIApplication()
		app.launch()
		let cancelButton = app.buttons["Cancel"]
		if cancelButton.exists {
			cancelButton.tap()
		}
	}

	func testShouldHaveDefaultValuesForTimer() throws {
		let app = XCUIApplication()
		let minPicker = app.staticTexts["mins"]
		let hourPicker = app.staticTexts["hrs"]

		app.launch()

		guard let minString = minPicker.value as? String, let hourString = hourPicker.value as? String, let min = Int(minString), let hour = Int(hourString) else {
			XCTAssert(true == false)
			return

		}

		XCTAssert(min == DefaultTimerValues.minutes)
		XCTAssert(hour == DefaultTimerValues.hour)
	}

	func testShouldStartAndEndTimerProperly() throws {
		let app = XCUIApplication()
		let startButton = app.buttons["Start"]
		let minPicker = app.staticTexts["mins"]
		let hourPicker = app.staticTexts["hrs"]
		let cancelButton = app.buttons["Cancel"]
		let header = app.staticTexts["Next feeding in..."]

		app.launch()
		XCTAssert(header.exists)
		XCTAssert(minPicker.exists)
		XCTAssert(hourPicker.exists)
		XCTAssert(startButton.exists)
		XCTAssertFalse(cancelButton.exists)
		startButton.tap()
		sleep(2)

		XCTAssert(header.exists)
		XCTAssertFalse(minPicker.exists)
		XCTAssertFalse(hourPicker.exists)
		XCTAssertFalse(startButton.exists)
		XCTAssert(cancelButton.exists)

		cancelButton.tap()
		XCTAssert(header.exists)
		XCTAssert(minPicker.exists)
		XCTAssert(hourPicker.exists)
		XCTAssert(startButton.exists)
		XCTAssertFalse(cancelButton.exists)
	}

	func testShouldCorrectlySetTimerText() throws {
		let app = XCUIApplication()
		let startButton = app.buttons["Start"]
		let timerText = app.staticTexts["TimerCountdown"]

		app.launch()
		startButton.tap()
		let countDownText = timerText.label
		print(countDownText)
		XCTAssert(countDownText == "\(DefaultTimerValues.hour):00:00")
	}
}
