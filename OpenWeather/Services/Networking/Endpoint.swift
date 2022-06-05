//
//  Endpoint.swift
//  OpenWeather
//
//  Created by Rayan Saeed on 05/06/2022.
//

import Foundation

protocol Endpoint {
	var base: String { get }
	var path: String { get }
	var quertyItems: [URLQueryItem] { get }
}

extension Endpoint {
	var urlComponents: URLComponents {
		var components = URLComponents(string: base)!
		components.queryItems = quertyItems
		components.path = path
		return components
	}

	var request: URLRequest {
		let url = urlComponents.url!
		return URLRequest(url: url)
	}
}
