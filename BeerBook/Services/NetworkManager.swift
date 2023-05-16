//
//  NetworkManager.swift
//  BeerBook
//
//  Created by Ilnur on 16.05.2023.
//

import Foundation

let baseUrl = URL(string: "https://api.punkapi.com/v2/beers")!

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping (Data) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
}
