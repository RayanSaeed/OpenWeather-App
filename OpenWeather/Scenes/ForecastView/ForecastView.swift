//
//  ForecastView.swift
//  OpenWeather
//
//  Created by Rayan Saeed on 06/06/2022.
//

import SwiftUI

struct ForecastView: View {

	var viewModel: Model

	var body: some View {
		VStack {
			Label(viewModel.time, systemImage: "clock")
				.font(.callout)
				.padding(.bottom)
			VStack {
				AsyncImage(url: viewModel.weatherIconUrl) { image in
					image
						.resizable()
						.fixedSize()
				} placeholder: {
					ProgressView()
				}
				.frame(width: 100, height: 100)

				VStack {
					Text(viewModel.temperature)
						.font(.largeTitle)
					VStack {
						Text(viewModel.description)
						HStack {
							Text(viewModel.maxTemperature)
							Text(viewModel.minTemperature)
						}
					}
				}
			}
		}
	}
}

struct ForecastView_Previews: PreviewProvider {
	let viewModel = ForecastView.Model(
		id: 1654580807,
		time: "03:00 PM",
		weatherIconUrl: nil,
		description: "Clear Sky",
		temperature: "32 •C",
		minTemperature: "27 •C",
		maxTemperature: "38 •C"
	)

	static var previews: some View {
		Group {
			ForecastView(viewModel: .init(
				id: 1654580807,
				time: "03:00 PM",
				date: "June 08",
				weatherIconUrl: URL(string: "https://openweathermap.org/img/wn/01d@2x.png"),
				description: "Clear Sky",
				temperature: "32 •C",
				minTemperature: "27 •C",
				maxTemperature: "38 •C"
			))
			ForecastView(viewModel: .init(
				id: 1654580807,
				time: "03:00 PM",
				date: "June 08",
				weatherIconUrl: URL(string: "https://openweathermap.org/img/wn/01d@2x.png"),
				description: "Clear Sky",
				temperature: "32 •C",
				minTemperature: "27 •C",
				maxTemperature: "38 •C"
			))
			.preferredColorScheme(.dark)
		}
		.previewLayout(.fixed(width: 300, height: 300))
	}
}
