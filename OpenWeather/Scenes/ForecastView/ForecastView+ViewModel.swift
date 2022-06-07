//
//  ForecastView+ViewModel.swift
//  OpenWeather
//
//  Created by Rayan Saeed on 06/06/2022.
//

import Foundation
import Combine

extension ForecastView {

	struct ViewModel: Hashable {
		var id: Int
		var time: String = "00:00"
		var date: String = "-- ---"

		var weatherIconUrl: URL?
		var description: String = "- -"

		var temperature: String = "-"
		var minTemperature: String = "-"
		var maxTemperature: String = "-"
	}
}

/// This is a helper struct to represent forecasts for a single day
struct DayForecast {
	let date: String
	let forecastViewModels: [ForecastView.ViewModel]
}
