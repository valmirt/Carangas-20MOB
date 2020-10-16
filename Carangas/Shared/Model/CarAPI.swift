//
//  CarAPI.swift
//  Carangas
//
//  Created by Valmir Junior on 29/09/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

enum APIError: Error {
    case badURL
    case taskError
    case noResponse
    case decodeError
    case noData
    case invalidStatusCode(Int)
    
    var errorMessage: String {
        switch self {
        case .badURL:
            return "URL inválida."
        case .taskError:
            return "Erro ao executar a requisição."
        case .noResponse:
            return "Problemas ao receber dados do servidor."
        case .decodeError:
            return "Dados inválidos."
        case .noData:
            return "Não foi possível receber os dados."
        case .invalidStatusCode(let code):
            return "Erro na requisição: Status - \(code)."
        }
    }
}

class CarAPI {
    
    private let basePath = "https://carangas.herokuapp.com/cars"
    private let config: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true //Signal 3G/4G
        configuration.timeoutIntervalForRequest = 60
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        configuration.httpMaximumConnectionsPerHost = 5
        
        return configuration
    }()
    private lazy var session = URLSession(configuration: config)
    
    func loadCars(onComplete: @escaping (Result<[Car], APIError>) -> Void) {
        guard let url = URL(string: basePath) else {
            onComplete(.failure(.badURL))
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                onComplete(.failure(.taskError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                onComplete(.failure(.noResponse))
                return
            }
            
            if !(200...299 ~= response.statusCode) {
                onComplete(.failure(.invalidStatusCode(response.statusCode)))
                return
            }
            
            guard let data = data else {
                onComplete(.failure(.noData))
                return
            }
            
            do {
                let cars = try JSONDecoder().decode([Car].self, from: data)
                onComplete(.success(cars))
            } catch {
                onComplete(.failure(.decodeError))
            }
        }
        task.resume()
    }
    
    func deleteCar(_ car: Car, onComplete: @escaping (Result<Void, APIError>) -> Void) {
        request("DELETE", car, onComplete: onComplete)
    }
    
    func createCar(_ car: Car, onComplete: @escaping (Result<Void, APIError>) -> Void) {
        request("POST", car, onComplete: onComplete)
    }
    
    func updateCar(_ car: Car, onComplete: @escaping (Result<Void, APIError>) -> Void) {
        request("PUT", car, onComplete: onComplete)
    }
    
    private func request(_ httpMethod: String, _ car: Car, onComplete: @escaping (Result<Void, APIError>) -> Void) {
        let urlString = "\(basePath)/\(car._id ?? "")"
        guard let url = URL(string: urlString) else {
            onComplete(.failure(.badURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = try? JSONEncoder().encode(car)
        urlRequest.httpMethod = httpMethod
        
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                onComplete(.failure(.noResponse))
                return
            }
            
            if !(200...299 ~= response.statusCode) {
                onComplete(.failure(.invalidStatusCode(response.statusCode)))
                return
            }
            
            if data != nil {
                onComplete(.success(()))
            } else {
                onComplete(.failure(.noData))
            }
        }.resume()
    }
}
