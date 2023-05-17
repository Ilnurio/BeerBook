//
//  ViewController.swift
//  BeerBook
//
//  Created by Ilnur on 16.05.2023.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var taglineLabel: UILabel!
    
    private var beers: [Beer] = []
    
    func configure(with beer: Beer) {
        descriptionLabel.text = beer.description
        taglineLabel.text = beer.tagline
    }
}

// MARK: - NetWorking
//extension DescriptionViewController {
//   func fetchDescriptionOfBeer() {
//       URLSession.shared.dataTask(with: baseUrl) { [weak self] data, _, error in
//           guard let data else {
//               print(error?.localizedDescription ?? "No error description")
//               return
//           }
//
//           do {
//               let decoder = JSONDecoder()
//               self?.beers = try decoder.decode([Beer].self, from: data)
//               DispatchQueue.main.async {
//                   for beer in self?.beers ?? [] {
//                       self?.configure(with: beer)
//                   }
//               }
//           } catch {
//               print(error.localizedDescription)
//           }
//       }.resume()
//   }
//}
