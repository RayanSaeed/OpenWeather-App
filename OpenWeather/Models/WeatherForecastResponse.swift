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

	struct Forecast: Codable {
		/// Time in epoch standard
		let time: Int

		/// Time and Date of forecast in following format
		/// 2022-06-06 15:00:00
		/// yyyy-MM-dd HH:mm:ss
		let date: String

		/// Temperatures for the 3-hr period
		let temperature: Temperature

		let weather: [Weather]

		struct Temperature: Codable {
			/// Temperature (in Kelvin Unit) for current time
			let current: Double

			/// Min Temperature (in Kelvin Unit) for the 3hr period.
			let minimum: Double

			/// Max Temperature (in Kelvin Unit) for the 3hr period.
			let maximum: Double

			private enum CodingKeys: String, CodingKey {
				case current = "temp"
				case minimum = "temp_min"
				case maximum = "temp_max"
			}
		}

		struct Weather: Codable {
			/// Description of weather in lowercase
			let description: String

			/// Icon code of image, which can be grabbed using
			/// the following endpoint in OpenWeather API
			/// http://openweathermap.org/img/wn/10d@2x.png
			/// where "10d" is the icon-code
			let icon: String
		}

		private enum CodingKeys: String, CodingKey {
			case time = "dt"
			case date = "dt_txt"
			case temperature = "main"
			case weather
		}
	}
}

extension WeatherForecastResponse.Forecast.Weather {
	var iconImageUrl: String {
		"http://openweathermap.org/img/wn/\(icon)@2x.png"
	}
}
