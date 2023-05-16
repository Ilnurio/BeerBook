//
//  beerItemCell.swift
//  Beer Book
//
//  Created by Ilnur on 14.05.2023.
//

import UIKit

final class BeerItemCell: UITableViewCell {
    @IBOutlet var beerNameLabel: UILabel!
    @IBOutlet var degreeLabel: UILabel!
    @IBOutlet var beerImage: UIImageView!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with beer: Beer) {
        beerNameLabel.text = beer.name
        degreeLabel.text = "Degree: \(beer.abv) %"
        
        // загрузка изображений
//        DispatchQueue.global().async { [weak self] in
//            guard let imageData = try? Data(contentsOf: beer.imageUrl) else { return }
//            DispatchQueue.main.async {
//                self?.beerImage.image = UIImage(data: imageData)
//            }
//        }
        
        networkManager.fetchImage(from: beer.imageUrl) { [weak self] imageData in
            self?.beerImage.image = UIImage(data: imageData)
        }
    }
}
