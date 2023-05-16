//
//  CollectionViewController.swift
//  Beer Book
//
//  Created by Ilnur on 14.05.2023.
//

import UIKit

final class BeerCollectionViewController: UITableViewController {
    
    private var beers: [Beer] = []

    // MARK: UICollectionViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        beers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerItem", for: indexPath)
        guard let cell = cell as? BeerItemCell else { return UITableViewCell() }
        
        let beer = beers[indexPath.row]
        cell.configure(with: beer)
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDescription" {
            guard let descriptionVC = segue.destination as? DescriptionViewController else { return }
            descriptionVC.fetchDescriptionOfBeer()
        }
    }
}

 // MARK: - NetWorking
extension BeerCollectionViewController {
    func fetchBeerCollection() {
        URLSession.shared.dataTask(with: baseUrl) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self?.beers = try decoder.decode([Beer].self, from: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
