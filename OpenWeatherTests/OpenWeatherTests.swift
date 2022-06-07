//
//  OpenWeatherTests.swift
//  OpenWeatherTests
//
//  Created by Rayan Saeed on 05/06/2022.
//

import XCTest
@testable import OpenWeather

class OpenWeatherTests: XCTestCase {

	// MARK: - Private data types

	private enum TestEnvironment: Environment {
		case test

		var baseURL: String { "https://www.google.com" }
		var headers: ReaquestHeaders? { .none }
	}

	// MARK: - Private properties

	private let env = TestEnvironment.test

	// MARK: - Tests

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
		let sut = OpenWeatherAPI(environment: env)

		// When
		let baseUrl = sut.environment.baseURL

		// Then
		XCTAssertEqual("https://www.google.com", baseUrl)
	}

	func testEndpoint_generates_non_nil_url() throws {
		// Given
		enum TestEndpoint: Endpoint {
			case custom

			var path: String {
				"/customPath"
			}

			var method: RequestMethod { .get }
			var headers: ReaquestHeaders? { nil }
			var parameters: RequestParameters? { nil }
		}

		// When
		let url = TestEndpoint.custom.urlRequest(with: env)?.url

		// Then
		XCTAssertNotEqual(url, nil)
	}

	func testEndpoint_generates_valid_url() throws {
		// Given
		enum TestEndpoint: Endpoint {
			case custom

			var path: String {
				"/customPath"
			}

			var method: RequestMethod { .get }
			var headers: ReaquestHeaders? { nil }
			var parameters: RequestParameters? { nil }
		}

		// When
		let url = TestEndpoint.custom.urlRequest(with: env)?.url

		// Then
		XCTAssertEqual(url?.absoluteString, "https://www.google.com/customPath")
	}
}
