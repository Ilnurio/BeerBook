//
//  CollectionViewController.swift
//  Beer Book
//
//  Created by Ilnur on 14.05.2023.
//

import UIKit

enum UserAction: CaseIterable {
    case beerLibrary
    case myCollection
    case aboutApp
    
    var title: String {
        switch self {
        case .beerLibrary:
            return "Beer Library"
        case .myCollection:
            return "My Collection"
        case .aboutApp:
            return "About App"
        }
    }
}

let baseUrl = URL(string: "https://api.punkapi.com/v2/beers")!

class MainCollectionViewController: UICollectionViewController {
    
    private let userActions = UserAction.allCases
    private let beerItem = BeerItemCell()
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainItem", for: indexPath)
        guard let cell = cell as? MainItemCell else {return UICollectionViewCell() }
        cell.userActionLabel.text = userActions[indexPath.item].title
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
            
        case .beerLibrary: performSegue(withIdentifier: "showBeerLibrary", sender: nil)
        case .myCollection: performSegue(withIdentifier: "showMyCollection", sender: nil)
        case .aboutApp: performSegue(withIdentifier: "showAboutApp", sender: nil)
        }
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBeerLibrary" {
            guard let beerCollectionVC = segue.destination as? BeerCollectionViewController else { return }
            beerCollectionVC.fetchBeerCollection()
        }
    }
}

 // MARK: - UICollectionViewDelegateFlowLayout
extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
