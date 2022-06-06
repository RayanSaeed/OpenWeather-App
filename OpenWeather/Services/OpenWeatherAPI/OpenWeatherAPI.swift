//
//  OpenWeatherAPI.swift
//  OpenWeather
//
//  Created by Rayan Saeed on 06/06/2022.
//

import Combine
import Foundation

final class OpenWeatherAPI: CombineAPI {

	var session: URLSession
	var environment: Environment

	init(configuration: URLSessionConfiguration = .default, environment: Environment) {
		self.session = URLSession(configuration: configuration)
		self.environment = environment
	}

	convenience init() {
		self.init(configuration: .default, environment: OpenWeatherAPIEnvironment.development)
	}

	func getWeatherForecast(_ requestEndpoint: OpenWeatherEndpoint) -> AnyPublisher<WeatherForecastResponse, Error> {
		guard let request = requestEndpoint.urlRequest(with: environment) else {
			return Fail(error: APIError.badRequest)
				.eraseToAnyPublisher()
		}

		return execute(request, decodingType: WeatherForecastResponse.self)
	}
}

enum OpenWeatherEndpoint {
	case fiveDaysForecast(city: String)
}

extension OpenWeatherEndpoint: Endpoint {

	var apiKey: String { "d0b672479c4c02996829d75ed06b97c3" }

	var path: String {
		switch self {
			case .fiveDaysForecast:
				return "/forecast"
		}
	}

	var method: RequestMethod {
		switch self {
			case .fiveDaysForecast:
				return .get
		}
	}

	var headers: ReaquestHeaders? {
		switch self {
			case .fiveDaysForecast:
				return .none
		}
	}

	var parameters: RequestParameters? {
		switch self {
			case .fiveDaysForecast(let city):
				return [
					"q": city,
					"appid": apiKey
				]
		}
	}
}

// 44.8125° N, 20.4612° E
