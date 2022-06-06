//
//  APIError.swift
//  OpenWeather
//
//  Created by Rayan Saeed on 05/06/2022.
//

import Foundation

/// Enum of API Errors
enum APIError: Error {
	/// No data received from the server.
	case noData
	/// The server response was invalid (unexpected format).
	case invalidResponse
	/// The request was rejected: 400-499
	case badRequest
	/// Encoutered a server error.
	case serverError
	/// There was an error parsing the data.
	case parseError
	/// Unknown error.
	case unknown

	var localizedDescription: String {
		switch self {
			case .noData:
				return "❌ No data returned"
			case .invalidResponse:
				return "❌ Invalid Response"
			case .badRequest:
				return "❌ Bad request"
			case .serverError:
				return "❌ Server error"
			case .parseError:
				return "❌ Parsing error"
			case .unknown:
				return "❌ Unknown error occured"
		}
	}
}
