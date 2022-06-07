//
//  WeatherForecastResponse.swift
//  OpenWeather
//
//  Created by Rayan Saeed on 06/06/2022.
//

import Foundation

struct WeatherForecastResponse: Codable {
	let city: City
	let list: [Forecast]
}

extension WeatherForecastResponse {
	struct City: Codable {
		let id: Int
		let name: String
	}
}
