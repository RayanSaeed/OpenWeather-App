//
//  WeatherForecast+ViewModel.swift
//  OpenWeather
//
//  Created by Rayan Saeed on 06/06/2022.
//

import Foundation

extension WeatherForecastView {
	@MainActor class ViewModel: ObservableObject {

	}
}

/*
 // 1
 final class MoviesProvider: ObservableObject {

	 // MARK:- Subscribers
   // 2
	 private var cancellable: AnyCancellable?

	 // MARK:- Publishers
   // 3
	 @Published var movies: [MovieViewModel] = []

	 // MARK:- Private properties
   // 4
	 private let client = MovieClient()

	 init() {
	   // 5
		 cancellable = client.getFeed(.nowPlaying)
			 .sink(receiveCompletion: { _ in },
			 receiveValue: {
				 self.movies = $0.results.map { MovieViewModel(movie: $0) }
			 })
	 }
 }
 */
