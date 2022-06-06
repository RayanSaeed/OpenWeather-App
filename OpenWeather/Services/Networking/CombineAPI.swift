//
//  CombineAPI.swift
//  OpenWeather
//
//  Created by Rayan Saeed on 05/06/2022.
//

import Combine
import Foundation

protocol CombineAPI {
	var session: URLSession { get }

	func execute<T>(_ request: URLRequest,
					decodingType: T.Type,
					qualityOfService: DispatchQoS.QoSClass,
					queue: DispatchQueue,
					decoder: JSONDecoder,
					retries: Int) -> AnyPublisher<T, Error> where T: Decodable
}

extension CombineAPI {

	func execute<T>(_ request: URLRequest,
					decodingType: T.Type,
					qualityOfService: DispatchQoS.QoSClass = .default,
					queue: DispatchQueue = .main,
					decoder: JSONDecoder = .init(),
					retries: Int = 1) -> AnyPublisher<T, Error> where T: Decodable {
		return session.dataTaskPublisher(for: request)
			.tryMap { data, response in

				guard let response = response as? HTTPURLResponse else {
					throw APIError.invalidResponse
				}

				switch verify(response: response) {
					case .success:
						return data
					case .failure(let error):
						throw error
				}
			}
			.subscribe(on: DispatchQueue.global(qos: qualityOfService))
			.receive(on: queue)
			.decode(type: T.self, decoder: decoder)
			.retry(retries)
			.eraseToAnyPublisher()
	}

	/// Checks if the HTTP status code is valid and there is data otherwise returns an error.
	/// - Parameters:
	///   - data: The data or file URL .
	///   - response: The received  optional `URLResponse` instance.
	/// - Returns: A `Result` instance.
	private func verify(response: HTTPURLResponse) -> Result<Bool, Error> {
		switch response.statusCode {
			case 200...299:
				return .success(true)
			case 400...499:
				return .failure(APIError.badRequest)
			case 500...599:
				return .failure(APIError.serverError)
			default:
				return .failure(APIError.unknown)
		}
	}
}
