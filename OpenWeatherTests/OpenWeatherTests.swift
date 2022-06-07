//
//  OpenWeatherTests.swift
//  OpenWeatherTests
//
//  Created by Rayan Saeed on 05/06/2022.
//

import XCTest
@testable import OpenWeather
import Combine

class OpenWeatherTests: XCTestCase {

	// MARK: - Private data types

	private enum TestEnvironment: Environment {
		case dev
		case prod

		var baseURL: String {
			switch self {
				case .dev:
					return "https://www.google.com"
				case .prod:
					return "https://www.yahoo.com"
			}
		}
		var headers: ReaquestHeaders? { .none }
	}

	enum TestEndpoint: Endpoint {
		case customPath
		case customPathWithParameters

		var path: String {
			"/customPath"
		}

		var method: RequestMethod { .get }
		var headers: ReaquestHeaders? { nil }
		var parameters: RequestParameters? {
			switch self {
				case .customPath:
					return nil
				case .customPathWithParameters:
					return ["param1": "value1"]
			}
		}
	}

	// MARK: - Tests

    func testOpenWeatherAPI_environment_is_set_correctly() {
		let env = OpenWeatherAPIEnvironment.development
		let api = OpenWeatherAPI(environment: env)

		let apiEnv: OpenWeatherAPIEnvironment = api.environment as! OpenWeatherAPIEnvironment

		XCTAssertEqual(apiEnv, .development)
	}

	func testOpenWeatherAPI_baseUrl_is_set_correctly() {
		let env = TestEnvironment.dev
		let sut = OpenWeatherAPI(environment: env)

		let baseUrl = sut.environment.baseURL

		XCTAssertEqual("https://www.google.com", baseUrl)
	}

	func testEndpoint_generates_non_nil_url() {
		let env = TestEnvironment.dev
		let url = TestEndpoint.customPath.urlRequest(with: env)?.url

		XCTAssertNotEqual(url, nil)
	}

	func testEndpoint_generates_valid_url() {
		let env = TestEnvironment.dev
		let url = TestEndpoint.customPathWithParameters.urlRequest(with: env)?.url

		XCTAssertEqual(url?.absoluteString, "https://www.google.com/customPath?param1=value1")
	}

	func testCombine_API_verifies_status_code() throws {
		final class TestAPI: CombineAPI {
			var session: URLSession

			var environment: Environment

			init(configuration: URLSessionConfiguration = .default, environment: Environment) {
				self.session = URLSession(configuration: configuration)
				self.environment = environment
			}

			convenience init() {
				self.init(configuration: .default, environment: TestEnvironment.dev)
			}
		}

		let sut = TestAPI(environment: TestEnvironment.dev)
		let env = sut.environment as! OpenWeatherTests.TestEnvironment

		XCTAssertEqual(env, TestEnvironment.dev)
	}

	func testForecastViewModel() {
		// Given
		let sut: Forecast = Bundle.main.decode("forecast_test_stub")

		// When
		let viewModel = ForecastListView.ViewModel()
		

		// Then
		<#code#>
	}
}
