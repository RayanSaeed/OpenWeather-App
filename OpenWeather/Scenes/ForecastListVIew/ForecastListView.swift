//
//  ForecastListView.swift
//  OpenWeather
//
//  Created by Rayan Saeed on 05/06/2022.
//

import SwiftUI

struct ForecastListView: View {

	@StateObject private var viewModel = ViewModel()

	var body: some View {
		NavigationView {
			VStack {
				Picker("", selection: $viewModel.dataSource) {
					Text(viewModel.segmentedControlTitles.0)
						.tag(0)
					Text(viewModel.segmentedControlTitles.1)
						.tag(1)
				}
				.pickerStyle(.segmented)
				.padding(.horizontal)
				.onChange(of: viewModel.dataSource) { _ in
					getWeatherForecast()
				}

				List {
					ForEach(viewModel.forecastViewModels, id: \.date) { item in
						Text(item.date)
							.font(.title2).bold()
							.listRowSeparator(.hidden)
							.padding([.leading, .top])
						TabView {
							ForEach(item.forecastViewModels, id: \.self) { item in
								ForecastView(viewModel: item)
									.padding()
									.frame(width: 300)
									.background(Color(UIColor.systemBackground))
									.cornerRadius(15)
									.shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
							}
						}
						.frame(height: 380)
						.tabViewStyle(.page)
						.indexViewStyle(.page(backgroundDisplayMode: .interactive))
						.onAppear {
							UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.label
							UIPageControl.appearance().pageIndicatorTintColor = UIColor.secondaryLabel
						}
					}
					.listRowInsets(EdgeInsets())
				}
				.listStyle(GroupedListStyle())
			}
			.edgesIgnoringSafeArea(.bottom)
			.navigationTitle(viewModel.navigationTitle)
			.onAppear {
				// For now, we are fetching forecast only for "Belgrade"
				// but we can easily replace it with any other city by
				// connecting it to UI
				getWeatherForecast()
			}
		}
	}

	private func getWeatherForecast() {
		viewModel.getWeatherForecast(for: "Belgrade")
	}
}

struct WeatherForecastView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			ForecastListView()
			ForecastListView()
				.preferredColorScheme(.dark)
		}
	}
}
