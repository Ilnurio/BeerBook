//
//  NetworkManager.swift
//  BeerBook
//
//  Created by Ilnur on 16.05.2023.
//

import Foundation

// обработка ошибок
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

let baseUrl = URL(string: "https://api.punkapi.com/v2/beers")!


final class NetworkManager {
    static let shared = NetworkManager()
    private var beers:[Beer] = []
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    // универсальный метод fetch()
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    // MARK: - postRequest
    func postRequest(with parameters: [String: Any], to url: URL, completion: @escaping(Result<Any, NetworkError>) -> Void) {
        let serializedData = try? JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = serializedData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, let response else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                completion(.success(json))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
}


