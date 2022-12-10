//
//  CarService.swift
//  Carangas
//
//  Created by Alves Brito, Eric(AWF) on 21/06/22.
//

import Foundation

protocol CarServiceProtocol {
    func loadCars(onComplete: @escaping (Result<[Car], CarServiceError>) -> Void)
    func deleteCar(_ car: Car, onComplete: @escaping (Result<Void, CarServiceError>) -> Void)
}

final class CarService: CarServiceProtocol {
	private let basePath = "https://carangas.herokuapp.com/cars"
	private let configuration: URLSessionConfiguration = {
		let configuration = URLSessionConfiguration.default
		configuration.allowsCellularAccess = true
		configuration.timeoutIntervalForRequest = 60
		configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
		configuration.httpMaximumConnectionsPerHost = 5
		return configuration
	}()
	private lazy var session = URLSession(configuration: configuration)
	
	func loadCars(onComplete: @escaping (Result<[Car], CarServiceError>) -> Void) {
		guard let url = URL(string: basePath) else {
			return onComplete(.failure(.badURL))
		}
		
		let task = session.dataTask(with: url) { data, response, error in
			if let _ = error {
				return onComplete(.failure(.taskError))
			}
			
			guard let response = response as? HTTPURLResponse else {
				return onComplete(.failure(.noResponse))
			}
			
			if !(200...299 ~= response.statusCode) {
				return onComplete(.failure(.invalidResponse(statusCode: response.statusCode)))
			}
			
			guard let data = data else {
				return onComplete(.failure(.noData))
			}
			
			do {
				let cars = try JSONDecoder().decode([Car].self, from: data)
				onComplete(.success(cars))
			} catch {
				return onComplete(.failure(.decodingError))
			}
		}
		task.resume()
	}
	
	func createCar(_ car: Car, onComplete: @escaping (Result<Void, CarServiceError>) -> Void) {
		request(car: car, httpMethod: "POST", onComplete: onComplete)
	}
	
	func updateCar(_ car: Car, onComplete: @escaping (Result<Void, CarServiceError>) -> Void) {
		request(car: car, httpMethod: "PUT", onComplete: onComplete)
	}
	
	func deleteCar(_ car: Car, onComplete: @escaping (Result<Void, CarServiceError>) -> Void) {
		request(car: car, httpMethod: "DELETE", onComplete: onComplete)
	}
	
	private func request(car: Car, httpMethod: String, onComplete: @escaping (Result<Void, CarServiceError>) -> Void) {
		let urlString = basePath + "/" + (car._id ?? "")
		guard let url = URL(string: urlString) else {
			return onComplete(.failure(.badURL))
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = httpMethod
		request.httpBody = try? JSONEncoder().encode(car)
		
		let task = session.dataTask(with: request) { data, response, error in
			if let _ = error {
				return onComplete(.failure(.taskError))
			}
			
			guard let response = response as? HTTPURLResponse else {
				return onComplete(.failure(.noResponse))
			}
			
			if !(200...299 ~= response.statusCode) {
				return onComplete(.failure(.invalidResponse(statusCode: response.statusCode)))
			}
			
			if let _ = data {
				return onComplete(.success(()))
			} else {
				return onComplete(.failure(.unknown))
			}
		}
		task.resume()
	}
}
