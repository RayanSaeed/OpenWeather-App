//
//  Request.swift
//  OpenWeather
//
//  Created by Rayan Saeed on 06/06/2022.
//

import Foundation

/// HTTP request methods.
enum RequestMethod: String {
	/// HTTP GET
	case get = "GET"
	/// HTTP POST
	case post = "POST"
	/// HTTP PUT
	case put = "PUT"
	/// HTTP PATCH
	case patch = "PATCH"
	/// HTTP DELETE
	case delete = "DELETE"
}

/// Type alias used for HTTP request headers.
typealias ReaquestHeaders = [String: String]

/// Type alias used for HTTP request parameters.
typealias RequestParameters = [String : Any?]
