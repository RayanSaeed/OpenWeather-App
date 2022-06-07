//
//  ForecastListView+Model.swift
//  OpenWeather
//
//  Created by Rayan Saeed on 06/06/2022.
//

import Foundation
import Combine
import Algorithms

extension ForecastListView {
	@MainActor class ViewModel: ObservableObject {
		// MARK: - Subscribers -
		private var cancellable: AnyCancellable?

		// MARK: - Publishers -
		@Published var dataSource: Int = 0 // By default we load data from the local JSON
		@Published var forecastViewModels = [DayForecast]()

		// MARK: - Public properties -
		var navigationTitle: String = "Weather Forecast"
		var segmentedControlTitles: (String, String) = ("JSON", "API")

		// MARK: - Private properties -
		private let api = OpenWeatherAPI()
		private var forecasts: [Forecast] = [] {
			didSet { convertDataSetIntoViewModels() }
		}

		// MARK: - Public methods -
		func getWeatherForecast(for city: String) {
			// First, we cancel any ongoing API requests
			cancellable?.cancel()

			// then we reset the previous data
			forecastViewModels = []

			// and then we fetch new data
			if dataSource == 0 {
				loadDataFromJson()
			} else {
				loadDataFromAPI(for: city)
			}
		}

		// MARK: - Private methods -
		private func loadDataFromJson() {
			let data: WeatherForecastResponse =  Bundle.main.decode("weather.json")
			forecasts = data.list
		}

		private func loadDataFromAPI(for city: String) {
			let api = OpenWeatherAPI()
			cancellable = api.getWeatherForecast(.fiveDaysForecast(city: city))
				.sink { _ in } receiveValue: { [weak self] response in
					self?.forecasts = response.list
				}
		}

		private func convertDataSetIntoViewModels() {
			let viewModels = forecasts.map {
				ForecastView.Model(
					id: $0.time,
					time: displayable(.time, forecast: $0),
					date: displayable(.date, forecast: $0),
					weatherIconUrl: $0.weather.first?.iconImageUrl,
					description: $0.weather.first?.description.capitalized ?? "",
					temperature: displayable(.temp, forecast: $0),
					minTemperature: displayable(.minTemp, forecast: $0),
					maxTemperature: displayable(.maxTemp, forecast: $0)
				)
			}
			forecastViewModels = viewModels.chunked { $0.date == $1.date }.map { .init(date: $0.first!.date, forecastViewModels: .init($0)) }
		}

		// MARK: - Private Enum -
		private enum Data {
			case time
			case date
			case temp
			case minTemp
			case maxTemp
		}

		// MARK: - Helper methods -
		private func displayable(_ data: Data, forecast: Forecast) -> String {
			switch data {
				case .time:
					return formatDate(forecast.time)
				case .date:
					let formatter = DateFormatter()
					formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
					guard let date = formatter.date(from: forecast.date) else { return "" }
					formatter.dateFormat = "MMM d"
					return formatter.string(from: date)
				case .temp:
					let temp = temperatureInCelcius(kelvinTemp: forecast.temperature.current)
					return "\(temp) °C"
				case .minTemp:
					let temp = temperatureInCelcius(kelvinTemp: forecast.temperature.current)
					return "H:\(temp)"
				case .maxTemp:
					let temp = temperatureInCelcius(kelvinTemp: forecast.temperature.current)
					return "L:\(temp)"
			}
		}

		private func formatDate(_ date: Int) -> String {
			let date = Date(timeIntervalSince1970: TimeInterval(date))
			let dateFormatter = DateFormatter()
			dateFormatter.timeStyle = DateFormatter.Style.short
			dateFormatter.timeZone = .current
			return dateFormatter.string(from: date)
		}

		private func temperatureInCelcius(kelvinTemp: Double) -> String {
			String(format: "%.0f", kelvinTemp - 273.15)
		}
	}
}
