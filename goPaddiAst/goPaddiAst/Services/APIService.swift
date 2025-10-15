//
//  APIService.swift
//  goPaddiAst
//
//  Created by Okoi Victory Ebri on 14/10/2025.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
    case serverError(String)
    case noData
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .serverError(let message):
            return message
        case .noData:
            return "No data received from server"
        }
    }
}

class APIService {
    static let shared = APIService()
    
    // Replace with your Beeceptor endpoint
    private let baseURL = "https://tripplanner.free.beeceptor.com"
    
    private init() {}
    
    // MARK: - Generic Request Method
    private func performRequest<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        body: Data? = nil,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.networkError(error)))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let message = "Server returned status code \(httpResponse.statusCode)"
                DispatchQueue.main.async {
                    completion(.failure(.serverError(message)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        task.resume()
    }
    
    // MARK: - Get All Trips
    func getAllTrips(completion: @escaping (Result<[Trip], APIError>) -> Void) {
        performRequest(endpoint: "/trips", method: "GET") { (result: Result<[Trip], APIError>) in
            completion(result)
        }
    }
    
    // MARK: - Get Single Trip
    func getTrip(id: String, completion: @escaping (Result<Trip, APIError>) -> Void) {
        performRequest(endpoint: "/trips/\(id)", method: "GET") { (result: Result<Trip, APIError>) in
            completion(result)
        }
    }
    
    // MARK: - Create Trip
    func createTrip(trip: CreateTripRequest, completion: @escaping (Result<Trip, APIError>) -> Void) {
        guard let body = try? JSONEncoder().encode(trip) else {
            completion(.failure(.invalidURL))
            return
        }
        
        performRequest(endpoint: "/trips", method: "POST", body: body) { (result: Result<Trip, APIError>) in
            completion(result)
        }
    }
    
    // MARK: - Update Trip
    func updateTrip(id: String, trip: CreateTripRequest, completion: @escaping (Result<Trip, APIError>) -> Void) {
        guard let body = try? JSONEncoder().encode(trip) else {
            completion(.failure(.invalidURL))
            return
        }
        
        performRequest(endpoint: "/trips/\(id)", method: "PUT", body: body) { (result: Result<Trip, APIError>) in
            completion(result)
        }
    }
    
    // MARK: - Delete Trip
    func deleteTrip(id: String, completion: @escaping (Result<Bool, APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/trips/\(id)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.networkError(error)))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(true))
            }
        }
        
        task.resume()
    }
}
