//
//  WeatherForecastView.swift
//  OpenWeather
//
//  Created by Rayan Saeed on 05/06/2022.
//

import SwiftUI

struct WeatherForecastView: View {
	@StateObject private var viewModel = ViewModel()

	var body: some View {
		Text("Hello, world!")
			.padding()
	}
}

struct WeatherForecastView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			WeatherForecastView()
			WeatherForecastView()
				.preferredColorScheme(.dark)
		}
	}
}

