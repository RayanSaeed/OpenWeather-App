//
//  Environment.swift
//  OpenWeather
//
//  Created by Rayan Saeed on 06/06/2022.
//

import Foundation

/// Protocol to which environments must conform.
protocol Environment {
	/// The base URL of the environment.
	var baseURL: String { get }

	/// The default HTTP request headers for the environment.
	var headers: ReaquestHeaders? { get }
}
