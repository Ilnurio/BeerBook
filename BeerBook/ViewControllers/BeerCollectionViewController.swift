//
//  CollectionViewController.swift
//  Beer Book
//
//  Created by Ilnur on 14.05.2023.
//

import UIKit

final class BeerCollectionViewController: UICollectionViewController {
    
    private let beerItem = BeerItemCell()
    private var beers: [Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBeerCollection()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "beerItem", for: indexPath)
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
}

 // MARK: - UICollectionViewDelegateFlowLayout
extension BeerCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 128)
    }
}

// MARK: - NetWorking
extension BeerCollectionViewController {
   func fetchBeerCollection() {
       let baseUrl = URL(string: "https://api.punkapi.com/v2/beers")!
       URLSession.shared.dataTask(with: baseUrl) { [weak self] data, _, error in
           guard let data else {
               print(error?.localizedDescription ?? "No error description")
               return
           }
           
           do {
               let decoder = JSONDecoder()
               self?.beers = try decoder.decode([Beer].self, from: data)
               DispatchQueue.main.async { [weak self] in
                   for beer in self?.beers ?? [] {
                       self?.beerItem.beerNameLabel.text = "Name: \(beer.name)"
                       self?.beerItem.degreeLabel.text = "Degree: \(beer.abv)"
                       
                       DispatchQueue.global().async { [weak self] in
                           guard let imageData = try? Data(contentsOf: beer.image_url) else { return }
                           DispatchQueue.main.async {
                               self?.beerItem.beerImageView.image = UIImage(data: imageData)
                           }
                       }
                   }
               }
           } catch {
               print(error.localizedDescription)
           }
       }.resume()
   }
}
