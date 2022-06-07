//
//  Endpoint.swift
//  OpenWeather
//
//  Created by Rayan Saeed on 05/06/2022.
//

import Foundation

protocol Endpoint {
	/// The path that will be appended to API's base URL.
	var path: String { get }
	
	/// The HTTP method.
	var method: RequestMethod { get }
	
	/// The HTTP headers/
	var headers: ReaquestHeaders? { get }
	
	/// The request parameters used as query parameters for GET requests,
	/// and in the HTTP body for POST, PUT and PATCH requests.
	var parameters: RequestParameters? { get }
}

extension Endpoint {

	///////////////////
	// MARK: - PUBLIC
	///////////////////

	/// Creates a URLRequest from this instance.
	/// - Parameter environment: The environment against which the `URLRequest` must be constructed.
	/// - Returns: An optional `URLRequest`.
	public func urlRequest(with environment: Environment) -> URLRequest? {
		// Create the base URL.
		guard let url = url(with: environment.baseURL) else {
			return nil
		}

		// Create a request with that URL.
		var request = URLRequest(url: url)

		// Append all related properties.
		request.httpMethod = method.rawValue
		request.allHTTPHeaderFields = headers

		return request
	}

	///////////////////
	// MARK: - PRIVATE
	///////////////////

	/// Creates a URL with the given base URL.
	/// - Parameter baseURL: The base URL string.
	/// - Returns: An optional `URL`.
	private func url(with baseURL: String) -> URL? {
		// Create a URLComponents instance to compose the url.
		guard var urlComponents = URLComponents(string: baseURL) else {
			return nil
		}

		// Add the request path to the existing base URL path
		urlComponents.path = urlComponents.path + path

		// Add query items to the request URL
		urlComponents.queryItems = queryItems

		return urlComponents.url
	}

	/// Returns the URLRequest's queryItems `[URLQueryItem]`
	private var queryItems: [URLQueryItem]? {
		// Chek if it is a GET method.
		guard method == .get, let parameters = parameters else {
			return nil
		}
		// Convert parameters to query items.
		return parameters.map { key, value in
			return URLQueryItem(name: key, value: "\(value ?? "")")
		}
	}
}
