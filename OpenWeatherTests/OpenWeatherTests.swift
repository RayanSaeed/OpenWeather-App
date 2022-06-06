//
//  OpenWeatherTests.swift
//  OpenWeatherTests
//
//  Created by Rayan Saeed on 05/06/2022.
//

import XCTest
@testable import OpenWeather

class OpenWeatherTests: XCTestCase {

    func testOpenWeatherAPI_environment_is_set_correctly() throws {
		// Given
		let env = OpenWeatherAPIEnvironment.development
		let api = OpenWeatherAPI(environment: env)

		// When
		let apiEnv: OpenWeatherAPIEnvironment = api.environment as! OpenWeatherAPIEnvironment

		// Then
		XCTAssertEqual(apiEnv, .development)
	}

	func testOpenWeatherAPI_baseUrl_is_set_correctly() throws {
		// Given
		enum TestEnvironment: Environment {
			case test

			var baseURL: String { "www.google.com" }
			var headers: ReaquestHeaders? { .none }
		}

		let env = TestEnvironment.test
		let api = OpenWeatherAPI(environment: env)

		// When
		let baseUrl = api.environment.baseURL

		// Then
		XCTAssertEqual("www.google.com", baseUrl)
	}


}
