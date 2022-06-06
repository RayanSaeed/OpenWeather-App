//
//  OpenWeatherAPIEnvironment.swift
//  OpenWeather
//
//  Created by Rayan Saeed on 06/06/2022.
//

import Foundation

/// Environments enum.
enum OpenWeatherAPIEnvironment {
	/// The development environment.
	case development
	/// The production environment.
	case production
}

extension OpenWeatherAPIEnvironment: Environment {

	/// The base URL of the given environment.
	var baseURL: String {
		switch self {
			case .development:
				// Since we don't have a dev url, so we will use the same one
				return "api.openweathermap.org/data/2.5/"
			case .production:
				return "api.openweathermap.org/data/2.5/"
		}
	}

	/// The default HTTP request headers for the given environment.
	var headers: ReaquestHeaders? {
		switch self {
			case .development, .production:
				return ["Content-Type" : "application/json"]
		}
	}
}
